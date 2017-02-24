Received: from eggs.gnu.org ([2001:4830:134:3::10]:50176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1chCAj-0008J6-Gz
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1chCAf-00065L-Hc
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:28:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1chCAf-00065A-9S
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:28:13 -0500
Date: Fri, 24 Feb 2017 09:24:16 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170224092416.GE3702@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170223105922.22989-1-berrange@redhat.com>
	<57a2a646-cce2-2b65-bce5-793ffaa1ec9b@redhat.com>
	<20170223120720.GM10047@redhat.com>
	<bbca2b55-aeba-8e46-cdfc-2552af587c47@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbca2b55-aeba-8e46-cdfc-2552af587c47@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] os: don't corrupt pre-existing
 memory-backend data with prealloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: Jitendra Kolhe <jitendra.kolhe@hpe.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Feb 24, 2017 at 10:05:17AM +0100, Michal Privoznik wrote:
> On 02/23/2017 01:07 PM, Daniel P. Berrange wrote:
> > On Thu, Feb 23, 2017 at 01:05:33PM +0100, Michal Privoznik wrote:
> >> On 02/23/2017 11:59 AM, Daniel P. Berrange wrote:
> >>> When using a memory-backend object with prealloc turned on, QEMU
> >>> will memset() the first byte in every memory page to zero. While
> >>> this might have been acceptable for memory backends associated
> >>> with RAM, this corrupts application data for NVDIMMs.
> >>>
> >>> Instead of setting every page to zero, read the current byte
> >>> value and then just write that same value back, so we are not
> >>> corrupting the original data.
> >>>
> >>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> >>> ---
> >>>
> >>> I'm unclear if this is actually still safe in practice ? Is the
> >>> compiler permitted to optimize away the read+write since it doesn't
> >>> change the memory value. I'd hope not, but I've been surprised
> >>> before...
> >>>
> >>> IMHO this is another factor in favour of requesting an API from
> >>> the kernel to provide the prealloc behaviour we want.
> >>>
> >>>  util/oslib-posix.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> >>> index 35012b9..8f5b656 100644
> >>> --- a/util/oslib-posix.c
> >>> +++ b/util/oslib-posix.c
> >>> @@ -355,7 +355,8 @@ void os_mem_prealloc(int fd, char *area, size_t memory, Error **errp)
> >>>  
> >>>          /* MAP_POPULATE silently ignores failures */
> >>>          for (i = 0; i < numpages; i++) {
> >>> -            memset(area + (hpagesize * i), 0, 1);
> >>> +            char val = *(area + (hpagesize * i));
> >>> +            memset(area + (hpagesize * i), 0, val);
> >>
> >> I think you wanted:
> >>
> >> memset(area + (hpagesize * i), val, 1);
> >>
> >> because what you are suggesting will overwrite even more than the first
> >> byte with zeroes.
> > 
> > Lol, yes, I'm stupid.
> > 
> > Anyway, rather than repost this yet, I'm interested if this is actually
> > the right way to fix the problem or if we should do something totally
> > different....
> 
> So, I've done some analysis and if the optimizations are enabled, this
> whole body is optimized away. Not the loop though. Here's what I've tested:
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> 
> int main(int argc, char *argv[])
> {
>     int ret = EXIT_FAILURE;
>     unsigned char *ptr;
>     size_t i, j;
> 
>     if (!(ptr = malloc(1024 * 4))) {
>         perror("malloc");
>         goto cleanup;
>     }
> 
>     for (i = 0; i < 4; i++) {
>         unsigned char val = ptr[i*1024];
>         memset(ptr + i * 1024, val, 1);
>     }
> 
>     ret = EXIT_SUCCESS;
>  cleanup:
>     free(ptr);
>     return ret;
> }
> 
> 
> But if I make @val volatile, I can enforce the compiler to include the
> body of the loop and actually read and write some bytes. BTW: if I
> replace memset with *(ptr + i * 1024) = val; and don't make @val
> volatile even the loop is optimized away.

Ok, yeah, it makes sense that the compiler can optimize that away without
volatile. I wonder if adding volatile has much of a performance impact on
this loop...

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
