Received: from eggs.gnu.org ([2001:4830:134:3::10]:48329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evLLU-0000Ma-Uy
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evLLT-0004cM-Ui
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:10:24 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:45263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evLLT-0004aU-O9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:10:23 -0400
Received: by mail-ot0-x232.google.com with SMTP id f11so14817922otj.12
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 04:10:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8ecafc78-5ea0-5d83-41d4-0b9b95bcdf21@gmail.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-11-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8grbFO7E0yoci_dwr2xnH8ujS8cJnpNxGdz=JOged=Gw@mail.gmail.com>
	<a35ca106-b405-8c07-95b6-ff65f324fae4@redhat.com>
	<CAFEAcA-08=3jyf1fpdD6AumJmbL=64iLOpoySVCfot7CXiD4Og@mail.gmail.com>
	<8ecafc78-5ea0-5d83-41d4-0b9b95bcdf21@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 11:10:02 +0000
Message-ID: <CAFEAcA9--5Ja9-jNVp7dJEN_y4is25NT9TSQcakDdSkpSV8R9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 10/14] hw/arm/smmuv3: Abort on vfio or
 vhost case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger.pro@gmail.com>
Cc: Auger Eric <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

On 12 March 2018 at 10:53, Eric Auger <eric.auger.pro@gmail.com> wrote:
> Hi Peter,
>
> On 09/03/18 18:59, Peter Maydell wrote:
>> On 9 March 2018 at 17:53, Auger Eric <eric.auger@redhat.com> wrote:
>>> Hi Peter,
>>> On 08/03/18 20:06, Peter Maydell wrote:
>>>> On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
>>>>> +static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
>>>>> +                                       IOMMUNotifierFlag old,
>>>>> +                                       IOMMUNotifierFlag new)
>>>>> +{
>>>>> +    if (old == IOMMU_NOTIFIER_NONE) {
>>>>> +        error_setg(&error_fatal,
>>>>> +                   "SMMUV3: vhost and vfio notifiers not yet supported");
>>>>> +    }
>>>>> +}
>>>>
>>>> Is this triggerable by the guest, or by the user on the command
>>>> line, or only by a bug in the board or other QEMU code?
>>> by the user on the command line.
>>
>> OK. Do they get this error immediately on startup, or only later
>> in execution? (If the latter, is it possible to make the error
>> happen earlier?)

> later in execution. We also have to handle the case where such device is
> hot-plugged. At best if could be done on smmu_find_add_as() by checking
> the type of attached device but this wouldn't happen much earlier. By
> the way we will soon support vhost and we will just rule out vfio
> integration by detecting map notifiers.

Hmm. error_fatal is a bit unfortunate for a hotplug event -- ideally
you would want to cause the hotplug to cleanly fail without aborting
the running QEMU session.

thanks
-- PMM
