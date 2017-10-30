Received: from eggs.gnu.org ([2001:4830:134:3::10]:38161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mattator@gmail.com>) id 1e94pQ-0003fR-K4
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 03:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mattator@gmail.com>) id 1e94pP-0005Dq-AN
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 03:49:48 -0400
Received: from mail-yw0-x234.google.com ([2607:f8b0:4002:c05::234]:48965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mattator@gmail.com>) id 1e94pP-0005Dd-48
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 03:49:47 -0400
Received: by mail-yw0-x234.google.com with SMTP id q1so10752817ywh.5
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 00:49:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0cf277479d9f46939d0eb18b7bdc46c8@EXCHCS32.ornl.gov>
References: <CADHp1NwU=HowMfgBGtcwnY25v_fL6qZ2gd469a2oZY+QQi2uFw@mail.gmail.com>
	<20171019205409.GA4170@flamenco>
	<545610a4882f4c5494b30b7eab66b984@EXCHCS32.ornl.gov>
	<CADHp1NxzGr_ijvGrUbmZf0NuUv+JwJZeA=8h4tZNn++SBA1yUw@mail.gmail.com>
	<0cf277479d9f46939d0eb18b7bdc46c8@EXCHCS32.ornl.gov>
From: Matt <mattator@gmail.com>
Date: Mon, 30 Oct 2017 16:49:45 +0900
Message-ID: <CADHp1NyfO3OeUs4tuCGgiAt6Ksfm+s4d6Y+HVqxStKYgnzhL2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Running Qemu in discrete time/step by step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Nutaro, James J." <nutarojj@ornl.gov>
Cc: "Emilio G. Cota" <cota@braap.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Hajime Tazaki <tazaki@wide.ad.jp>

Within the context of a simulator, qemu runs with a limited set of
devices so that removes some indeterminism but not all I guess.

VMsimint boasts exact reproducibility because they control all
outputs/inputs. I tried to look into their patch but the patch is
empty and instead there seems to be the partial (full ?) tree of qemu
1.6.
I suspect this might be quite some work to port this to the latest
qemu. It's sad because I really like the approach :)
(qemu changes in the latest archive of
http://www.ikr.uni-stuttgart.de/Content/IKRSimLib/Download/)

I guess I will stick to DCE with the hope that qemu considers the
usecase and make it easier.

Cheers

2017-10-24 6:33 GMT+09:00 Nutaro, James J. <nutarojj@ornl.gov>:
> I don't expect exact repeatability, but I haven't tested for it either. The machinery that prevents repeatability with replay will probably have the same effect in the adevs/qemu simulator.
>
> -----Original Message-----
> From: Matt [mailto:mattator@gmail.com]
> Sent: Monday, October 23, 2017 5:38 AM
> To: Nutaro, James J.
> Cc: Emilio G. Cota; qemu-devel@nongnu.org; Hajime Tazaki
> Subject: Re: [Qemu-devel] Running Qemu in discrete time/step by step
>
> I did not know about Qemu's record/replay mode which is an interesting
> feature but unneeded if a  2nd qemu run with the same inputs generated
> the same outputs (as it's the case with DCE).
> @nutaro Thanks for the updated patch. I will have a look at adevs. On
> a related note https://github.com/qemu/qemu/blob/master/docs/replay.txt
> enumerates different sources of indeterminism
> ==
> Replaying of the execution of virtual machine is bound by sources of
> non-determinism. These are inputs from clock and peripheral devices,
> and QEMU thread scheduling. Thread scheduling affect on processing events
> from timers, asynchronous input-output, and bottom halves.
> ==
>
> Do you manage to achieve perfect reproducibility with adevs + qemu ?
> If yes, is there any publication describing how you achieve this ?
>
> Best regards
> matt
>
> 2017-10-21 0:02 GMT+09:00 Nutaro, James J. <nutarojj@ornl.gov>:
>> Thanks for taking a look at the patch. The most recent version of the patch will also work with KVM if you need to speed things up. You can find it here:
>>
>> https://patchwork.kernel.org/patch/9960369/
>>
>> Somehow I messed up that post and it shows V8 when it should be V9.
>>
>> You can get the simulator that it works with at
>>
>> https://sourceforge.net/projects/adevs/
>>
>> If nothing else, this simulator would give you a blue print for integration with another tool.
>>
>> Jim
>>
>> -----Original Message-----
>> From: Emilio G. Cota [mailto:cota@braap.org]
>> Sent: Thursday, October 19, 2017 4:54 PM
>> To: Matt
>> Cc: qemu-devel@nongnu.org; Hajime Tazaki; Nutaro, James J.
>> Subject: Re: [Qemu-devel] Running Qemu in discrete time/step by step
>>
>> On Thu, Oct 19, 2017 at 14:14:12 +0900, Matt wrote:
>> (snip)
>>> - VMSimint does nearly that, it runs Qemu in discrete time but
>>> interface it with a JAVA simulator
>>> http://www.ikr.uni-stuttgart.de/Content/Publications/Archive/We_SIMUTools_2014_40209.pdf
>>> (with the code http://www.ikr.uni-stuttgart.de/Content/IKRSimLib/Download/)
>>> - http://web.ornl.gov/~nutarojj/adevs/ does sthg similar too
>>
>> Nutaro's work to interface with QEMU has been posted on the list:
>>   https://patchwork.kernel.org/patch/9572497/
>> I'm Cc'ing him in case he's not subscribed to the list.
>>
>>
>>> My questions would be:
>>> 1/ do you know of any other related work ?
>>
>> Is QEMU's record/replay mode of any use to you? Note that as is the
>> case with Nutaro's patch, you'll need icount mode (i.e. single-core)
>> enabled.
>>
>>> 2/ I believe there is interest from the research side but would it be
>>> possible to merge either approach or a similar one (adevs patch
>>> doesn't seem too big ~500 lines), would that be of interest for the
>>> Qemu comminity too ?
>>> 3/ if yes to 2. How to proceed, which one would be favorite ? if no,
>>> what should be improved ? or would that be a definitive no ?
>>
>> I think the adevs approach is reasonable. The patch hasn't gotten much
>> attention I guess because not many people care about this feature.
>> But if you could review the patch and certify that it works for you
>> (i.e. it works with simulators other than adevs), that could only help
>> the patch getting in.
>>
>> That said, I make no merging decisions so take this as just my opinion.
>>
>> Cheers,
>>
>>                 Emilio
>>
>
