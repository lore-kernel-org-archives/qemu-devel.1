Received: from eggs.gnu.org ([2001:4830:134:3::10]:40432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euMIe-0003l8-U5
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euMIe-0005GJ-31
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:59:25 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euMId-0005G0-UG
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:59:24 -0500
Received: by mail-oi0-x241.google.com with SMTP id x12so7582783oie.13
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 09:59:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a35ca106-b405-8c07-95b6-ff65f324fae4@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-11-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8grbFO7E0yoci_dwr2xnH8ujS8cJnpNxGdz=JOged=Gw@mail.gmail.com>
	<a35ca106-b405-8c07-95b6-ff65f324fae4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 17:59:02 +0000
Message-ID: <CAFEAcA-08=3jyf1fpdD6AumJmbL=64iLOpoySVCfot7CXiD4Og@mail.gmail.com>
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
To: Auger Eric <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

On 9 March 2018 at 17:53, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
> On 08/03/18 20:06, Peter Maydell wrote:
>> On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
>>> At the moment, the SMMUv3 does not support notification on
>>> TLB invalidation. So let's abort as soon as such notifier gets
>>> enabled.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>>  hw/arm/smmuv3.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index 384393f..5efe933 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -1074,12 +1074,23 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
>>>      dc->realize = smmu_realize;
>>>  }
>>>
>>> +static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
>>> +                                       IOMMUNotifierFlag old,
>>> +                                       IOMMUNotifierFlag new)
>>> +{
>>> +    if (old == IOMMU_NOTIFIER_NONE) {
>>> +        error_setg(&error_fatal,
>>> +                   "SMMUV3: vhost and vfio notifiers not yet supported");
>>> +    }
>>> +}
>>
>> Is this triggerable by the guest, or by the user on the command
>> line, or only by a bug in the board or other QEMU code?
> by the user on the command line.

OK. Do they get this error immediately on startup, or only later
in execution? (If the latter, is it possible to make the error
happen earlier?)

thanks
-- PMM
