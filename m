Received: from eggs.gnu.org ([2001:4830:134:3::10]:56947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cHCrs-0007rk-5g
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cHCrn-0004jB-7R
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:57:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1cHCrm-0004j1-Uf
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:57:19 -0500
References: <20161214125237.20850-1-maxime.coquelin@redhat.com>
	<20161214150852.5009.51009@loki>
	<20161214171501-mutt-send-email-mst@kernel.org>
	<20161214160215.5009.32685@loki> <20161214165341.5009.38941@loki>
	<20161214165604.5009.53902@loki>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <8df0a8ff-b82f-1d59-54ac-cffa384cc1b3@redhat.com>
Date: Wed, 14 Dec 2016 17:57:14 +0100
MIME-Version: 1.0
In-Reply-To: <20161214165604.5009.53902@loki>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Fix cross-version migration
 with older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, marcel@redhat.com, stefanha@redhat.com, cornelia.huck@de.ibm.com



On 12/14/2016 05:56 PM, Michael Roth wrote:
> Quoting Michael Roth (2016-12-14 10:53:41)
>> > Quoting Michael Roth (2016-12-14 10:02:15)
>>> > > Quoting Michael S. Tsirkin (2016-12-14 09:15:38)
>>>> > > > On Wed, Dec 14, 2016 at 09:08:52AM -0600, Michael Roth wrote:
>>>>> > > > > Quoting Maxime Coquelin (2016-12-14 06:52:37)
>>>>>> > > > > > This patch fixes a cross-version migration regression introduced
>>>>>> > > > > > by commit d1b4259f ("virtio-bus: Plug devices after features are
>>>>>> > > > > > negotiated").
>>>>>> > > > > >
>>>>>> > > > > > The problem is encountered when host's vhost backend does not support
>>>>>> > > > > > VIRTIO_F_VERSION_1, and migration is initiated from a v2.7 or prior
>>>>>> > > > > > machine with virtio-pci modern capabilities enabled to a v2.8 machine.
>>>>>> > > > > >
>>>>>> > > > > > In this case, modern capabilities get exposed to the guest by the source,
>>>>>> > > > > > whereas the target will detect version 1 is not supported so will only
>>>>>> > > > > > expose legacy capabilities.
>>>>>> > > > > >
>>>>>> > > > > > The problem is fixed by introducing a new "x-modern-broken" property,
>>>>>> > > > > > which is set in v2.7 and prior compatibility modes. Doing this, v2.7
>>>>>> > > > > > machine keeps its broken behaviour (enabling modern while version is
>>>>>> > > > > > not supported), and newer machines will behave correctly.
>>>>>> > > > > >
>>>>>> > > > > > Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>>>> > > > > > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>> > > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
>>>>>> > > > > > Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
>>>>>> > > > > > Cc: Marcel Apfelbaum <marcel@redhat.com>
>>>>>> > > > > > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>>>> > > > > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>>>>> > > > >
>>>>> > > > > Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>>> > > > >
>>>>> > > > > I can confirm this fixes the original issue I reported. I also did a
>>>>> > > > > number of sanity runs with 2.7/2.8/pc-i440fx-2.{6,7,8} using various
>>>>> > > > > combinations of disable-modern=true/false on hosts with/without virtio-1,
>>>>> > > > > and some tests with pseries machines as well, and everything seems to
>>>>> > > > > work.
>>>>> > > > >
>>>>> > > > > Thanks for the quick fix!
>>>> > > >
>>>> > > > FYI what I think does not work is a recent kernel on 2.7
>>>> > > > machine type and host without virtio 1.
>>>> > > > But this is not new.
>>> > >
>>> > > To clarify I was only testing migration compatibility, I assume virtio
>>> > > on 2.7 machines is still broken for the configuration you mentioned.
>>> > >
>>> > > The migration tests I ran on the virtio-1 host do cover networking over
>>> > > a virtio-net device before/after migration with reboots before/after
>>> > > migration as well though, and the guest in those cases had a 4.8 kernel,
>>> > > so I think the sanity checks I mentioned also apply for confirming
>>> > > virtio-net probe is succeeding in the guest.
>>> > >
>>> > > The non-virtio-1 runs are being done on my local machine and the tests
>>> > > in that case are a bit more basic and don't involve actively testing
>>> > > networking. I'll try some manual tests to check this. I guess the main
>>> > > things to confirm on that front are that after the patch virtio probing:
>>> > >
>>> > >   pc-i440fx-2.6, defaults -> succeeds
>>> > >   pc-i440fx-2.6, disable-modern=true -> succeeds
>>> > >   pc-i440fx-2.6, disable-modern=false -> fails
>>> > >
>>> > >   pc-i440fx-2.7, defaults -> fails
>>> > >   pc-i440fx-2.7, disable-modern=true -> succeeds
>>> > >   pc-i440fx-2.7, disable-modern=false -> fails
>>> > >
>>> > >   pc-i440fx-2.8, defaults -> succeeds
>>> > >   pc-i440fx-2.8, disable-modern=true -> succeeds
>>> > >   pc-i440fx-2.8, disable-modern=false -> succeeds
>> >
>> > I wasn't able to test disable-modern with pc-i440fx-2.6 due to the issue
>> > being fixes by proposed patch "machine: Convert abstract typename on
>> > compat_props to subclass names", but I think the rest of the cases align
>> > with expectations:
>> >
>> > 2.6, defaults: succeeds
>> >
>> > 2.7, defaults: fails
>> > 2.7, disable-modern=true: succeeds
>> > 2.7, disable-modern=false: fails
>> >
>> > 2.8, defaults: succeeds
>> > 2.7, disable-modern=true: succeeds
>> > 2.7, disable-modern=false: succeeds
> Typo on the latter 2, these were for pc-i440fx-2.8 as well.

Thanks Michael, I confirm this is in line with expectations.

  - Maxime
