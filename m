Received: from eggs.gnu.org ([2001:4830:134:3::10]:46419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fgBnR-0003IA-At
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fgBnM-0006az-DC
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:28:53 -0400
References: <1532010203-21331-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8vgqsZPCLsKCYzJCT+PXeKM-Pb9hcEDwNd4-R0vgT3tQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <edca94c2-2eaa-3d39-a133-50e3ee4837cf@redhat.com>
Date: Thu, 19 Jul 2018 18:28:37 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8vgqsZPCLsKCYzJCT+PXeKM-Pb9hcEDwNd4-R0vgT3tQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/timer/mc146818rtc: Fix introspection
 problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 19/07/2018 16:46, Peter Maydell wrote:
> On 19 July 2018 at 15:23, Thomas Huth <thuth@redhat.com> wrote:
>> There is currently a funny problem with the "mc146818rtc" device:
>> 1) Start QEMU like this:
>>    qemu-system-ppc64 -M pseries -S
>> 2) At the HMP monitor, enter "info qom-tree". Note that there is an
>>    entry for "/rtc (spapr-rtc)".
>> 3) Introspect the mc146818rtc device like this:
>>    device_add mc146818rtc,help
>> 4) Run "info qom-tree" again. The "/rtc" entry is gone now!
>>
>> The rtc_finalize() function of the mc146818rtc device has two bugs: First,
>> it tries to remove a "rtc" property, while the rtc_realizefn() added a
>> "rtc-time" property instead. And second, it should be done in an unrealize
>> function, not in a finalize function, to avoid that this causes problems
>> during introspection.
> 
> A device that adds a property to a machine is pretty weird...

Well, "there can be only one" RTC, since it subtractively decodes I/O
ports 70h and 71h.  But it's true that nowadays the RTC should present
the property, and the machine should add an alias to the RTC's property.
 In my defence, at the time we didn't have alias properties.

Paolo
