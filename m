Received: from eggs.gnu.org ([2001:4830:134:3::10]:33250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfNHJ-0004Uz-4T
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfNHF-00025u-T4
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:27:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dfNHF-00024t-Ng
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:27:45 -0400
Date: Wed, 9 Aug 2017 11:27:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170809112731.11659720.cohuck@redhat.com>
In-Reply-To: <ec749714-0cb8-4e75-c056-760bfb12ae7c@redhat.com>
References: <1502254778-14637-1-git-send-email-thuth@redhat.com>
	<1502254778-14637-2-git-send-email-thuth@redhat.com>
	<20170809110520.1fd23ddc.cohuck@redhat.com>
	<ec749714-0cb8-4e75-c056-760bfb12ae7c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] tests/boot-sector: Do not overwrite
 the x86 buffer on other architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Victor Kaplansky <victork@redhat.com>

On Wed, 9 Aug 2017 11:18:33 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 09.08.2017 11:05, Cornelia Huck wrote:
> > On Wed,  9 Aug 2017 06:59:37 +0200
> > Thomas Huth <thuth@redhat.com> wrote:

> >> @@ -80,16 +81,26 @@ int boot_sector_init(char *fname)
> >>          return 1;
> >>      }
> >>  
> >> -    /* For Open Firmware based system, we can use a Forth script instead */
> >> -    if (strcmp(qtest_get_arch(), "ppc64") == 0) {
> >> -        len = sprintf((char *)boot_sector, "\\ Bootscript\n%x %x c! %x %x c!\n",
> >> -                LOW(SIGNATURE), BOOT_SECTOR_ADDRESS + SIGNATURE_OFFSET,
> >> -                HIGH(SIGNATURE), BOOT_SECTOR_ADDRESS + SIGNATURE_OFFSET + 1);
> >> +    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) {
> >> +        /* Q35 requires a minimum 0x7e000 bytes disk (bug or feature?) */
> >> +        len = 0x7e000;  
> > 
> > Use the maximum of (0x7e000, sizeof(x86_boot_sector))? (Not that it is
> > likely that the boot sector will ever grow, but I think it is cleaner.)  
> 
> Sounds like a little bit of too much sanity checking for me, but ok, I
> can add it.

It's probably a bit paranoid, but I don't think it hurts. 

> 
> >> +        boot_code = g_malloc(len);  
> > 
> > Would g_malloc_0() be better?  
> 
> Good idea, the test is likely more predictable if we don't have random
> data in the file here (it should not really matter, but let's better be
> safe than sorry).
> 
> >> +        memcpy(boot_code, x86_boot_sector, sizeof x86_boot_sector);  
> > 
> > sizeof(x86_boot_sector)?  
> 
> The original code uses sizeof without parenthesis, so I think we should
> stay with that coding style.

After your patch, the original sizeof callers are gone, no? (I really
prefer the sizeof() variant...)
