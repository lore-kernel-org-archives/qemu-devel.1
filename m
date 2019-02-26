Received: from eggs.gnu.org ([209.51.188.92]:48099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyYfw-0000HD-9O
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:05:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyYfr-0000HY-Pz
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:05:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gyYfp-0000Dx-QD
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:05:14 -0500
References: <201902230335.59138.randrianasulu@gmail.com>
	<201902252029.28990.randrianasulu@gmail.com>
	<6de6b2df-380a-75dd-b3e9-4197ca4db866@redhat.com>
	<201902261158.09086.randrianasulu@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e9d2cf10-0c52-a1b6-2be9-e396bd76cf2f@redhat.com>
Date: Tue, 26 Feb 2019 10:05:02 +0100
MIME-Version: 1.0
In-Reply-To: <201902261158.09086.randrianasulu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Build error with git commit
 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116 on x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>, qemu-devel@nongnu.org

On 26/02/2019 09.58, Andrew Randrianasulu wrote:
> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Tuesday 26 February 2019 11:54:12 =D0=B2=D1=8B =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB=D0=B8:
>> On 25/02/2019 18.29, Andrew Randrianasulu wrote:
>>> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Monday 25 February 2019 19:19:01 Philippe Mathieu-Daudc3a9
>>>
>>> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
>>>> Hi Andrew,
>>>>
>>>> On 2/23/19 1:35 AM, Andrew Randrianasulu wrote:
>>>>> Hello!
>>>>>
>>>>> I just pulled latest git
>>>>
>>>> [...]
>>>>
>>>>> and default build with simple ./configure on slackware 14.2 x86-64 =
box
>>>>> failed like this:
>>>>>
>>>>> root@slax:~/src/qemu# LANG=3DC make -j 5
>>>>>         CHK version_gen.h
>>>>>   CC      qobject/block-qdict.o
>>>>>   CC      util/thread-pool.o
>>>>>   CC      util/main-loop.o
>>>>>   CC      util/qemu-timer.o
>>>>>   CC      util/iohandler.o
>>>>>   CC      util/aio-posix.o
>>>>> qobject/block-qdict.c: In function 'qdict_array_split':
>>>>> qobject/block-qdict.c:259:9: error: 'subqdict' may be used
>>>>> uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>>>>>          qlist_append_obj(*dst, subqobj ?: QOBJECT(subqdict));
>>>>>          ^
>>>>
>>>> That's odd, I can not reproduce with a simple ./configure:
>>>>
>>>> $ cat /etc/slackware-version
>>>> Slackware 14.2
>>>>
>>>> $ gcc --version
>>>> gcc (GCC) 5.5.0
>>>
>>> Well, then may be this is false positive, right now another qemu inst=
ance
>>> is busy inside same chroot, will try patch posted in earlier mail (af=
ter
>>> removing CFLAG I added for compiling qemu at all after this error).
>>>
>>> Thanks for trying to reproduce.
>>
>> Just to be sure: You don't compile with -O3 or -O1 or -O0 in the CFLAG=
S
>> here, do you?
>=20
> This time  it was -O3, but I got some corruption in ppc64le guest's X, =
so I plan=20
> to revert this -O3 back to default ....

Ok, then that's the problem here: GCC often produces some additional
"may be unused" warnings with -O3, and we normally only guarantee that
QEMU compiles without warnings when using the standard -O2 optimization
level.
So if you want to compile with -O3, you also have to specify
--disable-werror (or add -Wno-error=3Dmaybe-unitialized to the CFLAGS).
But unless you have really an urgent need for O3, I'd rather recommend
to compile with the well-tested O2 optimization level instead.

 Thomas
