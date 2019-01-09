Received: from eggs.gnu.org ([209.51.188.92]:48830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghDjw-0007Ms-OR
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghDjv-0006Pd-Rz
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:17:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ghDjv-0006P3-Jm
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:17:47 -0500
References: <1546857926-5958-1-git-send-email-thuth@redhat.com>
	<20190109105818.GG3998@redhat.com>
	<ac1072de-07a9-3630-bf97-fd04c9f2de8a@redhat.com>
	<20190109114459.GK3998@redhat.com>
	<89b89818-00b8-44b5-04db-4e2571533e84@redhat.com>
	<87y37udljk.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f45f44ab-d967-6702-e362-56612401c268@redhat.com>
Date: Wed, 9 Jan 2019 14:17:42 +0100
MIME-Version: 1.0
In-Reply-To: <87y37udljk.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2019-01-09 14:10, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
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
> Switchinh back could be somewhat painful if we already started using C1=
1
> features.  And if we don't plan to, then what exactly will -std=3Dgnu11
> buy us?

With C11, we get safety for the "duplicated typedef" problem that we run
into regularly again and again, see e.g.:

https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html

 Thomas
