Received: from eggs.gnu.org ([209.51.188.92]:49368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghDmG-0000qr-7o
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:20:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghDmE-0001nU-Ax
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:20:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ghDmC-0001VC-Ba
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:20:10 -0500
References: <1546857926-5958-1-git-send-email-thuth@redhat.com>
	<20190109105818.GG3998@redhat.com>
	<ac1072de-07a9-3630-bf97-fd04c9f2de8a@redhat.com>
	<20190109114459.GK3998@redhat.com>
	<89b89818-00b8-44b5-04db-4e2571533e84@redhat.com>
	<20190109125854.GM3998@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <860317b6-6489-9c18-bdf8-95a70fbec9b3@redhat.com>
Date: Wed, 9 Jan 2019 14:20:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190109125854.GM3998@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Force the C standard to gnu11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, pbonzini@redhat.com, peter.maydell@linaro.org

On 2019-01-09 13:58, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jan 09, 2019 at 01:52:02PM +0100, Thomas Huth wrote:
>> On 2019-01-09 12:44, Daniel P. Berrang=C3=A9 wrote:
>>> On Wed, Jan 09, 2019 at 12:25:43PM +0100, Thomas Huth wrote:
>>>> On 2019-01-09 11:58, Daniel P. Berrang=C3=A9 wrote:
>>>>> On Mon, Jan 07, 2019 at 11:45:26AM +0100, Thomas Huth wrote:
>>>>>> Different versions of GCC and Clang use different versions of the =
C standard.
>>>>>> This repeatedly caused problems already, e.g. with duplicated type=
defs:
>>>>>>
>>>>>>  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.ht=
ml
>>>>>>
>>>>>> or with for-loop variable initializers:
>>>>>>
>>>>>>  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.ht=
ml
>>>>>>
>>>>>> To avoid these problems, we should enforce the C language version =
to the
>>>>>> same level for all compilers. Since our minimum compiler versions =
are
>>>>>> GCC v4.8 and Clang v3.4 now, and both basically support "gnu11" al=
ready,
>>>>>> this seems to be a good choice.
>>>>>
>>>>> In 4.x   gnu11 is marked as experimental. I'm not really comfortabl=
e
>>>>> using experimental features - even if its warning free there's a ri=
sk
>>>>> it would silently mis-compile something.
>>>>>
>>>>> gnu99 is ok with 4.x - it is merely "incomplete".
>>>>
>>>> gnu11 has the big advantage that it also fixes the problem with
>>>> duplicated typedefs that are reported by older versions of Clang.
>>>>
>>>> Are you sure about the experimental character in 4.x? I just looked =
at
>>>> https://gcc.gnu.org/onlinedocs/gcc-4.8.5/gcc/Standards.html and it s=
ays:
>>>>
>>>> "A fourth version of the C standard, known as C11, was published in =
2011
>>>> as ISO/IEC 9899:2011. GCC has limited incomplete support for parts o=
f
>>>> this standard, enabled with -std=3Dc11 or -std=3Diso9899:2011."
>>>>
>>>> It does not say anything about "experimental" there. The word
>>>> "experimental" is only used for the C++ support, but we hardly have =
C++
>>>> code in QEMU -- if you worry about that, I could simply drop the
>>>> "-std=3Dgnu++11" part from my patch?
>>>
>>> I was looking at the "info gcc" docs on RHEL7, gcc-4.8.5-16.el7_4.1.x=
86_64:
>>>
>>>   "3.4 Options Controlling C Dialect
>>>
>>>        ....snip...
>>>
>>>      'gnu11'
>>>      'gnu1x'
>>>           GNU dialect of ISO C11.  Support is incomplete and
>>>           experimental.  The name 'gnu1x' is deprecated."
>>
>> Ok. Looks like the "Support is incomplete and experimental" sentence h=
as
>> been removed with GCC 4.9.0 here. So GCC 4.8 is likely pretty close
>> already. IMHO we could give it a try and enable gnu11 for QEMU with GC=
C
>> v4.8, too. If we later find problems, we could still switch back to
>> gnu99 instead. Other opinions?
>=20
> Our code is already cleanly compiling with gnu99 standard - the problem
> is merely that we sometimes introduce regressions due to not enforcing
> that standard level. I don't think the features in gnu11 are compelling
> enough to justify using something that's declared experimental.
What about the duplicated typedef problem? See:

 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html

That one occured with Clang, but I think we've had plenty of these in
the past with GCC, too...

 Thomas
