Received: from eggs.gnu.org ([2001:4830:134:3::10]:58284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIGXg-0006SV-AF
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIGXd-0005KU-6j
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:41:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39782 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fIGXd-0005Jo-1P
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:41:41 -0400
References: <20180504171540.25813-1-peter.maydell@linaro.org>
	<20180504171540.25813-19-peter.maydell@linaro.org>
	<CAFEAcA_USWqJ2ODDYKw0NbLTcwBqUdi-OiBBVuNC3yxp0manoA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d4490e85-ce78-26ac-03eb-67db143a252b@redhat.com>
Date: Mon, 14 May 2018 18:41:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_USWqJ2ODDYKw0NbLTcwBqUdi-OiBBVuNC3yxp0manoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 18/24] hw/arm/smmuv3: Event queue recording
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 05/14/2018 06:23 PM, Peter Maydell wrote:
> On 4 May 2018 at 18:15, Peter Maydell <peter.maydell@linaro.org> wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>>
>> Let's introduce a helper function aiming at recording an
>> event in the event queue.
> 
>> +void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>> +{
>> +    Evt evt;
>> +    MemTxResult r;
>>
>>      if (!smmuv3_eventq_enabled(s)) {
>>          return;
>>      }
>>
>> -    if (smmuv3_q_full(q)) {
>> +    EVT_SET_TYPE(&evt, info->type);
>> +    EVT_SET_SID(&evt, info->sid);
> 
> Hi Eric -- Coverity complains about use of uninitialized data
> here (CID 1391004). Evt is a struct, and there's no initializer
> where we declare it, so its fields are uninitialized. The
> The EVT_SET_TYPE and similar setters use deposit32() on fields
> in the struct, so they read the uninitialized existing values.
> In cases where we don't set all the fields in the event struct
> we'll end up leaking random uninitialized data from QEMU's
> stack into the guest.
> 
> Initializing the struct with "Evt evt = {};" ought to satisfy
> Coverity and fix the data leak.

Sure I will send a patch.

Thanks

Eric
> 
> thanks
> -- PMM
> 
