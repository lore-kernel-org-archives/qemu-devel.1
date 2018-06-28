Received: from eggs.gnu.org ([2001:4830:134:3::10]:58390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fYgQO-0004ID-Up
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 19:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fYgQL-0003Zp-2r
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 19:34:04 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:46168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fYgQK-0003XR-H2
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 19:34:00 -0400
Received: by mail-ed1-x543.google.com with SMTP id r17-v6so6141475edo.13
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 16:34:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5e9b9ca6-b493-d10b-be98-9b9eb480c685@redhat.com>
References: <20180626151038.24771-1-sameeh@daynix.com>
	<20180626151038.24771-2-sameeh@daynix.com>
	<5e9b9ca6-b493-d10b-be98-9b9eb480c685@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Fri, 29 Jun 2018 02:33:58 +0300
Message-ID: <CAKPgXcGQGqfwAw132jKq5UaFhaPR8PnfGf4NiXgYGoo7FwR5Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] qga-win: prevent crash when executing
 fsinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Jun 29, 2018 at 12:44 AM, Eric Blake <eblake@redhat.com> wrote:

> On 06/26/2018 10:10 AM, Sameeh Jubran wrote:
>
>> From: Sameeh Jubran <sjubran@redhat.com>
>>
>> The fsinfo command is currently implemented for Windows only and it's disk
>> parameter can be enabled by adding the define "CONFIG_QGA_NTDDSCSI" to
>> the qga
>> code. When enabled and executed the qemu-ga crashed with the following
>> message:
>>
>> ------------------------------------------------
>> File qapi/qapi-visit-core.c, Line 49
>>
>> Expression: !(v->type & VISITOR_OUTPUT) || *obj)
>> ------------------------------------------------
>>
>> After some digging, turns out that the GuestPCIAddress is null and the
>> qapi visitor doesn't like that, so we can always allocate it instead and
>> initiate all it's members to -1.
>>
>
> Adding Markus for a qapi back-compat question.
>
> Is faking an invalid address better than making the output optional
> instead?
>
> +++ b/qga/commands-win32.c
>> @@ -485,6 +485,11 @@ static GuestPCIAddress *get_pci_info(char *guid,
>> Error **errp)
>>       char *buffer = NULL;
>>       GuestPCIAddress *pci = NULL;
>>       char *name = g_strdup(&guid[4]);
>> +    pci = g_malloc0(sizeof(*pci));
>> +    pci->domain = -1;
>> +    pci->slot = -1;
>> +    pci->function = -1;
>> +    pci->bus = -1;
>>
>
> Right now, we have:
>
> ##
> # @GuestDiskAddress:
> #
> # @pci-controller: controller's PCI address
> # @bus-type: bus type
> # @bus: bus id
> # @target: target id
> # @unit: unit id
> #
> # Since: 2.2
> ##
> { 'struct': 'GuestDiskAddress',
>   'data': {'pci-controller': 'GuestPCIAddress',
>            'bus-type': 'GuestDiskBusType',
>            'bus': 'int', 'target': 'int', 'unit': 'int'} }
>
> and the problem you ran into is that under certain conditions, we have no
> idea what to populate in GuestPCIAddress.  Your patch populates garbage
> instead; but I'm wondering if it would be better to instead mark
> pci-controller as optional, where code that CAN populate it would set
> has_pci_controller=true, and the code that crashed will now work by leaving
> the struct NULL (and has_pci_controller=false).  But that removes output
> that the client may expect to be present, hence, this is a back-compat
> question of the best way to approach this.

Since all of the fields are ints, I believe that "-1" is very informative
even though I don't like this approach but it does preserve backward
compatibility as you've already clarified.

I don't want to assume anything but this bug has been laying around for
quite a while and no one complained, moreover,  the disk option is not
enabled by default in upstream code so I don't think that backward
compatibility is actually disturbed but then again this is just an
assumption.

One more thing to consider is the second patch of this series which
actually was the root cause of why we didn't allocate the " GuestDiskAddress"
struct which is some registry keys being absent for the specific device
which would leave us with two options:
1. Don not return anything for all of the fields (leave it null)
2. Return partial information
I think that the second option is preferable for obvious reasons.

I am not that familiar with schema files, but it is possible to make int
fields optional too?

I can live with either approaches, maintainers, it's your call :)

Thanks for the review!

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>



-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
