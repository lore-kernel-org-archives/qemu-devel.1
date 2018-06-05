Received: from eggs.gnu.org ([2001:4830:134:3::10]:41340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQB0L-0001ym-AO
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQB0I-0003BP-3j
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:24:01 -0400
Date: Tue, 5 Jun 2018 14:23:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180605142353.2ff0632b.cohuck@redhat.com>
In-Reply-To: <d1cae0f9-7185-5b2d-0576-422747da7e78@redhat.com>
References: <1527671818-23809-1-git-send-email-thuth@redhat.com>
	<1527671818-23809-4-git-send-email-thuth@redhat.com>
	<20180604113619.0ef8ccbd.cohuck@redhat.com>
	<d1cae0f9-7185-5b2d-0576-422747da7e78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] pc-bios/s390-ccw/net: Try to load
 pxelinux.cfg file accoring to the UUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

On Tue, 5 Jun 2018 14:04:18 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 04.06.2018 11:36, Cornelia Huck wrote:
> > On Wed, 30 May 2018 11:16:58 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> With the STSI instruction, we can get the UUID of the current VM instance,
> >> so we can support loading pxelinux config files via UUID in the file name,
> >> too.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  pc-bios/s390-ccw/netmain.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 45 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> >> index e84bb2b..7ece302 100644
> >> --- a/pc-bios/s390-ccw/netmain.c
> >> +++ b/pc-bios/s390-ccw/netmain.c
> >> @@ -235,6 +235,49 @@ static void net_release(filename_ip_t *fn_ip)
> >>  }
> >>  
> >>  /**
> >> + * Retrieve the Universally Unique Identifier of the VM.
> >> + * @return UUID string, or NULL in case of errors
> >> + */
> >> +static const char *get_uuid(void)
> >> +{
> >> +    register int r0 asm("0");
> >> +    register int r1 asm("1");
> >> +    uint8_t *mem, *buf, uuid[16];
> >> +    int i, chk = 0;
> >> +    static char uuid_str[37];
> >> +
> >> +    mem = malloc(2 * PAGE_SIZE);
> >> +    if (!mem) {
> >> +        puts("Out of memory ... can not get UUID.");
> >> +        return NULL;
> >> +    }
> >> +    buf = (uint8_t *)(((uint64_t)mem + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1));
> >> +    memset(buf, 0, PAGE_SIZE);
> >> +
> >> +    /* Get SYSIB 3.2.2 */
> >> +    r0 = (3 << 28) | 2;
> >> +    r1 = 2;
> >> +    asm volatile(" stsi 0(%2)\n" : : "d" (r0), "d" (r1), "a" (buf)
> >> +                 : "cc", "memory");  
> > 
> > Maybe check for cc == 3 here, just to be safe? (We can probably assume
> > a dbct >= 1 if it is successful, I think.)  
> 
> Sure, I can add that check. In case it's not available, this should have
> been catched by the "if (!chk)" below, but let's better be safe than
> sorry here.
> 
> >> +
> >> +    for (i = 0; i < 16; i++) {
> >> +        uuid[i] = buf[8 * 4 + 12 * 4 + i];  
> > 
> > Is there some way to make this offset less magic (offset of first vmdb
> > + offset of uuid inside vmdb)?  
> 
> Would a comment be sufficient? Or shall I copy the SysIB_322 structure
> from target/s390x/cpu.h over to the s390-ccw bios?

Copying the whole structure looks like overkill. What about

/* offset of first vmdb + offset of uuid inside vmdb */
#define VMDB_UUID_OFFSET (8 * 4 + 12 *4)

and using buf[VMDB_UUID_OFFSET + i]?

(If I see static expressions with concrete numbers, my eyes tend to
glaze over :)
