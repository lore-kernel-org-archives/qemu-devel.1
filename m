Received: from eggs.gnu.org ([209.51.188.92]:50553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH0O0-0001Nr-8U
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH0Nz-00031V-4V
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:19:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hH0Ny-0002z2-4e
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:19:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E035307D910
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 06:19:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190417190641.26814-1-armbru@redhat.com>
	<20190417190641.26814-8-armbru@redhat.com>
	<20190417160508.7b87d59a@x1.home>
Date: Thu, 18 Apr 2019 08:18:56 +0200
In-Reply-To: <20190417160508.7b87d59a@x1.home> (Alex Williamson's message of
	"Wed, 17 Apr 2019 16:05:08 -0600")
Message-ID: <87a7gnrg33.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 07/15] vfio: Report warnings with
 warn_report(), not error_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org

Alex Williamson <alex.williamson@redhat.com> writes:

> On Wed, 17 Apr 2019 21:06:33 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/vfio/pci.c | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>> 
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 504019c458..0142819ea6 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -947,8 +947,10 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>>      if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
>>          /* Since pci handles romfile, just print a message and return */
>>          if (vfio_blacklist_opt_rom(vdev) && vdev->pdev.romfile) {
>> -            error_printf("Warning : Device at %s is known to cause system instability issues during option rom execution. Proceeding anyway since user specified romfile\n",
>> -                         vdev->vbasedev.name);
>> +            warn_report("Device at %s is known to cause system instability"
>> +                        " issues during option rom execution",
>> +                        vdev->vbasedev.name);
>> +            error_printf("Proceeding anyway since user specified romfile\n");
>
> I'm confused, the original warning is "this device is know to have
> issues, proceeding because you asked me to".  Are we categorizing the
> first half as a warning and the latter as random uncategorized error
> spew?  Did an automated script chunk it this way because of the period
> and strict application of the "single phrase" specification of
> warn_report()?  If this is the recommended semantics, I'm not sure how
> I'd know to generate this myself for similar situations.  Should we
> instead try to express this in something acceptable as a single
> phrase?  Thanks,

This is an instance of the following error reporting pattern:

    concise error / warning message (one line, single phrase)
    additional information (free format)

We use error_report() / warn_report() for the former (this adds
decorations to the message), and error_printf() for the latter.

"git-grep -w error_printf" will lead you to other instances.  Recommend
to look with this series applied, because it removes misuses of
error_printf().

Particularly relevant instances are error_report_err() and
warn_report_err(): these print the error proper with error_report() /
warn_report_err(), and the hint, if any, with error_printf().

Clearer now?
