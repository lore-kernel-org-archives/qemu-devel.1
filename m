Received: from eggs.gnu.org ([2001:4830:134:3::10]:41860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSkMl-0007G6-21
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSkMh-0006dD-2L
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:06:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gSkMg-0006ca-Ou
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:05:58 -0500
References: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
	<1389c712-2e02-80c0-b9e1-4c45b54d35df@redhat.com>
	<69af56c7-413d-857f-829b-37d4747d0d96@redhat.com>
	<852011bf-424c-4215-2cef-f7456e8ab9aa@redhat.com>
	<b0d86936-bd72-56f3-7485-10c4f1cb6cd9@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f41a1ec8-b086-3383-13bc-0ae54cf7990f@redhat.com>
Date: Fri, 30 Nov 2018 16:05:53 +0100
MIME-Version: 1.0
In-Reply-To: <b0d86936-bd72-56f3-7485-10c4f1cb6cd9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] test: replace gtester with a
 TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On 2018-11-30 15:47, Cleber Rosa wrote:
>=20
>=20
> On 11/30/18 4:58 AM, Paolo Bonzini wrote:
>> On 30/11/18 08:21, Thomas Huth wrote:
>>> On 2018-11-29 21:43, Eric Blake wrote:
>>>> On 11/29/18 11:45 AM, Paolo Bonzini wrote:
>>>>> gtester is deprecated by upstream glib and it does not support test=
s
>>>>> that call g_test_skip in some glib stable releases.
>>>>>
>>>>> glib suggests instead using Automake's TAP support.=C2=A0 We do not=
 support
>>>>> Automake, but we can copy the code that beautifies the TAP output a=
nd
>>>>> use it.=C2=A0 I chose to use the Perl copy rather than the shell/aw=
k one,
>>>>> in order to reuse Perl's TAP parsing package, but I'm open to sugge=
stions
>>>>> about which language to use.
>>>>
>>>> I'm less familiar with the TAP protocol than I'd like to admit, but =
I
>>>> did find:
>>>>
>>>> https://blog.gtk.org/2018/07/11/news-from-glib-2-58/
>>>>
>>>> which corroborates your claim that switching to Automake's TAP parse=
r is
>>>> indeed a recommended approach to avoid the now-deprecated gtester.
>>>
>>> Hmm, do we really have to maintain our own version of a test runner n=
ow?
>>
>> Well, that's what you get for using a custom build system but it's
>> "just" an output beautifier really.  I could just "grep -ve ^# -e ^ok"
>> but it wouldn't look very nice (plus things that start as 1-line shell
>> scripts end up being the same as the thing you're trying to replace).
>>
>> I don't think it will be a big maintenance headache---just like most
>> other files in scripts/, some of which have had exactly zero commits
>> since they were added.  In fact, Automake has hardly changed its drive=
r
>> since the first commit.

OK, fair.

>>> There's already some effort going on to use avocado in "make
>>> check-acceptance" ... maybe we could use avocado as replacement for
>>> gtester, too?
>>
>> Avocado does not have the required functionality, unfortunately.  It c=
an
>> produce TAP, but not consume it.  Also, Python libraries for TAP do no=
t
>> abound and are generally not shipped with the OS (apart from Perl, whi=
ch
>> basically invented TAP, the language with the most TAP libraries seem =
to
>> be JavaScript!).
>=20
> Avocado can't currently consume TAP (it produces it, though), but it ha=
s
> some integration with glib based tests:
>=20
> https://avocado-framework.readthedocs.io/en/66.0/optional_plugins/glib.=
html
>=20
> But, there may be bits missing to fully replae gtests.  Given that we
> have been adding features to Avocado based on QEMU requirements, we can
> certainly look at adding missing pieces there.  If this sounds like
> something you'd be interested in, I can come up with an integration
> proposal.

FWIW, it seems basically to work, indeed:

$ export QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
$ avocado run --loaders glib -- tests/pxe-test tests/cdrom-test
JOB ID     : 67657631c2f1f80e34d90fe0c2c05e05aab6f1ba
JOB LOG    : /home/thuth/avocado/job-results/job-2018-11-30T10.02-6765763=
/job.log
 (01/12) tests/pxe-test:/x86_64/pxe/ipv4/pc/e1000: PASS (6.46 s)
 (02/12) tests/pxe-test:/x86_64/pxe/ipv4/pc/virtio-net-pci: PASS (6.47 s)
 (03/12) tests/pxe-test:/x86_64/pxe/ipv4/q35/e1000e: PASS (6.46 s)
 (04/12) tests/pxe-test:/x86_64/pxe/ipv4/q35/virtio-net-pci: PASS (6.46 s=
)
 (05/12) tests/cdrom-test:/x86_64/cdrom/boot/default: PASS (0.25 s)
 (06/12) tests/cdrom-test:/x86_64/cdrom/boot/virtio-scsi: PASS (0.25 s)
 (07/12) tests/cdrom-test:/x86_64/cdrom/boot/isapc: PASS (0.24 s)
 (08/12) tests/cdrom-test:/x86_64/cdrom/boot/am53c974: PASS (0.25 s)
 (09/12) tests/cdrom-test:/x86_64/cdrom/boot/dc390: PASS (0.25 s)
 (10/12) tests/cdrom-test:/x86_64/cdrom/boot/lsi53c895a: PASS (0.26 s)
 (11/12) tests/cdrom-test:/x86_64/cdrom/boot/megasas: PASS (0.15 s)
 (12/12) tests/cdrom-test:/x86_64/cdrom/boot/megasas-gen2: PASS (0.15 s)
RESULTS    : PASS 12 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |=
 CANCEL 0
JOB TIME   : 28.31 s
JOB HTML   : /home/thuth/avocado/job-results/job-2018-11-30T10.02-6765763=
/results.html

 Thomas
