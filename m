Received: from eggs.gnu.org ([2001:4830:134:3::10]:58539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7l36-0004Ib-Up
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7l33-0006A8-0a
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:58:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d7l32-00068z-NK
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:58:08 -0400
References: <87pofj8kek.fsf@linaro.org>
	<20170508153625.y7jhzv32go5fzlwh@aurel32.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <addc4f06-5554-0a8c-b651-3c921a148bfb@redhat.com>
Date: Mon, 8 May 2017 17:58:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170508153625.y7jhzv32go5fzlwh@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Future of SoftFloat use in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Aleksandar Markovic <aleksandar.markovic@imgtec.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <rth@twiddle.net>

On 08.05.2017 17:36, Aurelien Jarno wrote:
> Hi,
>=20
> On 2017-05-08 15:58, Alex Benn=C3=A9e wrote:
>> Hi,
>>
>> We've got a task coming up to implement half-precision floating point
>> (FP16) for ARMv8.2. As you know pretty much all our floating point in
>> QEMU is handled by our internal fork of John R. Hauser's BSD SoftFloat
>> library. Our current implementation is based on version 2a which doesn=
't
>> support FP16.
>>
>> As it happens there has been a new release of SoftFloat recently.
>> Version 3 is a complete re-write which made a number of changes, some
>> notable ones being:
>>
>>   - Complete rewrite, different use license than earlier releases.
>>   - Renaming most types and functions, upgrading some algorithms
>>     - restructuring the source files, and making SoftFloat into a true=
 library.
>>   - Added functions to convert between floating-point and unsigned int=
egers, both 32-bit and 64-bit (uint32_t and uint64_t).
>>   - Added functions for fused multiply-add, for all supported floating=
-point formats except 80-bit double-extended-precision.
>>   - Added support for a fifth rounding mode, near_maxMag (round to nea=
rest, with ties to maximum magnitude, away from zero).
>>
>> And in the most recent release as of February 2017, 3c:
>>
>>   - Added optional rounding mode odd (round to odd, also known as jamm=
ing).
>>   - Implemented the common 16-bit =E2=80=9Chalf-precision=E2=80=9D flo=
ating-point format (float16_t)
>>
>> See: http://www.jhauser.us/arithmetic/SoftFloat-3c/doc/SoftFloat-histo=
ry.html
>>
>> Of course the softfloat in QEMU's tree hasn't been static either. We'v=
e
>> made numerous changes over the years to add and fix various features,
>> including features that have since been added to the upstream softfloa=
t.
>> It seems unlikely we could switch to the newer softfloat without riski=
ng
>> breaking something. However if we look at back-porting stuff from the
>> newer library we essentially get to own our version of softfloat
>> forever.
>=20
> There have been many many changes in our forked version of softfloat:
> qNaN/sNaN, IEEE754-2008 functions, squash input denormal, many floatx80
> fixes, ...

Note that we've apparently also got plenty of bugs in our version of
softloat left, for example:

- https://bugs.launchpad.net/qemu/+bug/645662
- http://lists.nongnu.org/archive/html/qemu-ppc/2017-05/msg00187.html

... would be interesting to know whether such issues are fixed with the
newer version of softfloat...

 Thomas
