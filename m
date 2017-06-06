Received: from eggs.gnu.org ([2001:4830:134:3::10]:56751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIJbq-0003AV-W4
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIJbn-0006dG-NA
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:53:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIJbn-0006d3-Ed
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:53:39 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1496387804.git.maozy.fnst@cn.fujitsu.com>
	<ffa2cc4d0706fa522a5e581af14dadb03aec323a.1496387804.git.maozy.fnst@cn.fujitsu.com>
	<20170606182354-mutt-send-email-mst@kernel.org>
	<87efuxjdpx.fsf@dusky.pond.sub.org>
	<20170606210555-mutt-send-email-mst@kernel.org>
Date: Tue, 06 Jun 2017 20:53:31 +0200
In-Reply-To: <20170606210555-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Tue, 6 Jun 2017 21:06:42 +0300")
Message-ID: <87lgp5eyms.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/6] pci: Clean up error checking in
 pci_add_capability()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: marcel@redhat.com, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, Jun 06, 2017 at 06:14:02PM +0200, Markus Armbruster wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > On Fri, Jun 02, 2017 at 03:54:37PM +0800, Mao Zhongyi wrote:
>> >> On success, pci_add_capability2() returns a positive value. On
>> >> failure, it sets an error and return a negative value.
>> >> 
>> >> pci_add_capability() laboriously checks this behavior. No other
>> >> caller does. Drop the checks from pci_add_capability().
>> >> 
>> >> Cc: mst@redhat.com
>> >> Cc: marcel@redhat.com
>> >> Cc: armbru@redhat.com
>> >> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> >> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
>> >> ---
>> >>  hw/pci/pci.c | 6 +-----
>> >>  1 file changed, 1 insertion(+), 5 deletions(-)
>> >> 
>> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> >> index 98ccc27..53566b8 100644
>> >> --- a/hw/pci/pci.c
>> >> +++ b/hw/pci/pci.c
>> >> @@ -2270,12 +2270,8 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
>> >>      Error *local_err = NULL;
>> >>  
>> >>      ret = pci_add_capability2(pdev, cap_id, offset, size, &local_err);
>> >> -    if (local_err) {
>> >> -        assert(ret < 0);
>> >> +    if (ret < 0) {
>> >>          error_report_err(local_err);
>> >> -    } else {
>> >> -        /* success implies a positive offset in config space */
>> >> -        assert(ret > 0);
>> >>      }
>> >>      return ret;
>> >>  }
>> >
>> >
>> > I don't see why this is a good idea. You drop a bunch of
>> > asserts, so naturally code is slightly tighter. We could gain
>> > the same by building with NDEBUG but we don't, we rather
>> > have more safety.
>> 
>> It's a good idea because it's what we do basically everywhere when a
>> function sets an error and returns a distinct error value.
>
> We typically just do
>
          func(arg1, arg2, &local_err);
>         if (local_err) {
>             error_report_err(local_err);
> 		...
> 	}

That one's fine.

Equally fine:

          ret = func(arg1, arg2, &local_err);
          if (ret < 0) {
              error_report_err(local_err);
              ...
          }

When func(...) is short, then

          if (func(arg1, arg2, &local_err) < 0) {
              error_report_err(local_err);
              ...
          }

is also fine.

Whether you check the Error * variable or a distinct error return value
is purely a matter of taste (I prefer return value when possible).
Keeping matters of taste locally consistent can make sense.

What matters is keeping the error checking short and to the point.
Asserting that the callee returns the distinct error value if and only
if it sets an error is unusual precisely because it's not worth the
distraction.  Mao Zhongyi's patch cleans it up here.
