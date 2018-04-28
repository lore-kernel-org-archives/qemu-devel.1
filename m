Received: from eggs.gnu.org ([2001:4830:134:3::10]:60585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fCMJO-0007KW-Tu
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 05:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fCMJN-0005Yl-MN
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 05:38:34 -0400
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c]:54805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1fCMJN-0005Ye-Gf
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 05:38:33 -0400
Received: by mail-it0-x22c.google.com with SMTP id z6-v6so849300iti.4
	for <qemu-devel@nongnu.org>; Sat, 28 Apr 2018 02:38:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000e01d3ded3$127660d0$37632270$@ru>
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
	<CAFXrp_dOLnuoBEhL0eUJtobRWq7gjgAR8X48Xb3JeNx1J4eHEw@mail.gmail.com>
	<000e01d3ded3$127660d0$37632270$@ru>
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Sat, 28 Apr 2018 10:38:12 +0100
Message-ID: <CAFXrp_fO7FqUrk+JTwGDEGCUjLJ2m8f0SRSv3n--VuBk7ZgOBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 00/17] reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>

On Sat, Apr 28, 2018 at 10:27 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>
>
>> -----Original Message-----
>> From: Ciro Santilli [mailto:ciro.santilli@gmail.com]
>> Sent: Saturday, April 28, 2018 11:13 AM
>> To: Pavel Dovgalyuk
>> Subject: Re: [RFC PATCH 00/17] reverse debugging
>>
>> Forgetting about debugging, I belive there is a deadlock in the replay
>> at 63d426dfa4fbfac3d50cda3f553cd975de2b85ea , but it is rare.
>>
>> I have only reproduced it on ARM so far, and I haven't checked pre-patch.
>>
>> The setup is https://github.com/cirosantilli/qemu-
>> test/tree/6a3497f0d84e7c86ef80f7322e24e8a149b93214
>> with images-ab21ef58deed8536bc159c2afd680a4fabd68510.zip
>>
>> Then try to run it several times with:
>>
>> i=0; while true; do date; echo $i; ../qemu-test/arm/rr; i=$(($i+1)); done
>>
>> I think the deadlock can happen in a few different places, but the
>> most common is when the kernel is doing disk related stuff, the last
>> messages before getting stuck are:
>
> It usually happens when there is some bugs in the implementation of the virtual devices.
> Our customers mostly emulates x86-based systems, therefore most of
> the ARM hardware is untested.
>

Hi Pete, do you know anything about this? Traces at:
http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg05218.html
command at: https://github.com/cirosantilli/qemu-test/blob/6a3497f0d84e7c86ef80f7322e24e8a149b93214/arm/rr

@Pavel: I recommend always replying to both me and to qemu-devel to
preserve a better history of our talk on the tracker.

>> [   11.530325] ALSA device list:
>> [   11.531451]   No soundcards found.
>>
>> and what would follow on a normal replay would be:
>>
>> [   11.551904] EXT4-fs (vda): couldn't mount as ext3 due to feature
>> incompatibilities
>> [   11.619238] EXT4-fs (vda): mounted filesystem without journal. Opts: (null)
>>
>> I then attach GDB with:
>>
>> gdb -q ./arm-softmmu/qemu-system-arm `pgrep qemu`
>
>
>
>
> Pavel Dovgalyuk
>
