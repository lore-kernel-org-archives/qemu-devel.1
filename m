Received: from eggs.gnu.org ([2001:4830:134:3::10]:51708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRFcx-0000ps-CY
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRFct-0003wB-Im
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:55:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cRFct-0003vx-Ay
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:55:27 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1479108340-3453-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1479108340-3453-4-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170110194722-mutt-send-email-mst@kernel.org>
	<c54d2492-e501-73c7-dea9-25e719c1669d@redhat.com>
Date: Wed, 11 Jan 2017 10:55:24 +0100
In-Reply-To: <c54d2492-e501-73c7-dea9-25e719c1669d@redhat.com> (Paolo
	Bonzini's message of "Tue, 10 Jan 2017 18:58:39 +0100")
Message-ID: <8760lludir.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 03/10] pci: Convert msix_init() to Error
 and fix callers to check it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Hannes Reinecke <hare@suse.de>, Dmitry Fleytman <dmitry@daynix.com>, Gerd Hoffmann <kraxel@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/01/2017 18:54, Michael S. Tsirkin wrote:
>> On Mon, Nov 14, 2016 at 03:25:33PM +0800, Cao jin wrote:
>>> msix_init() reports errors with error_report(), which is wrong when
>>> it's used in realize().  The same issue was fixed for msi_init() in
>>> commit 1108b2f.
>>>
>>> For some devices(like e1000e, vmxnet3) who won't fail because of
>>> msix_init's failure, suppress the error report by passing NULL error object.
>>>
>>> Bonus: add comment for msix_init.
>>>
>>> CC: Jiri Pirko <jiri@resnulli.us>
>>> CC: Gerd Hoffmann <kraxel@redhat.com>
>>> CC: Dmitry Fleytman <dmitry@daynix.com>
>>> CC: Jason Wang <jasowang@redhat.com>
>>> CC: Michael S. Tsirkin <mst@redhat.com>
>>> CC: Hannes Reinecke <hare@suse.de>
>>> CC: Paolo Bonzini <pbonzini@redhat.com>
>>> CC: Alex Williamson <alex.williamson@redhat.com>
>>> CC: Markus Armbruster <armbru@redhat.com>
>>> CC: Marcel Apfelbaum <marcel@redhat.com>
>>>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>> Reviewed-by: Hannes Reinecke <hare@suse.com>
>>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> 
>> I'd rather add a new API. Once that is merged you can make device
>> changes avoiding a flag day. Merge this through individual trees. At the
>> end of the day we can drop the old API when it's no longer needed.
>
> I think that's the worst.  We don't need another partial transition and

Seconded.

> this series is all but big.  The main issue is that it was handled badly
> in the past, so people tend not to trust it.
>
> If anything, if there are independent patches in the series that can be
> merged through USB or SCSI trees, before this one, we can do that.

I guess some of the later patches are follow-up cleanups that could be
merged separately.  Might require reordering, then re-review.  But would
this really be worth the trouble?  Merging through another tree is no
pixie dust for quality.  If we can get the review and testing we need
only by merging every shard through the exact right tree, we're doing it
wrong.

Yes, we absolutely want a maintainer to review patches, and yes, that's
not trivial for work spanning subsystems.  But we got the R-bys alright.

Elsewhere in this thread, you ask for specific testing in addition to a
maintainer's R-by.  I think that's fair.
