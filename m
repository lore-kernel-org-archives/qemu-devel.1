Received: from eggs.gnu.org ([2001:4830:134:3::10]:52864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f1EgX-0004Kw-04
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f1EgV-0003AX-0v
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:16:28 -0400
References: <cover.1522245129.git.jcody@redhat.com>
	<8172e5c57529e2275e5d8f1cbe06bd9bc88a8dd4.1522245129.git.jcody@redhat.com>
	<CAMxuvawv2Q13Ge=Pim3Uy9JG65rQaCU2CCHZav6jsPirUdqmAg@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <aca6e618-c639-ccaa-1638-e4252d49b0d2@redhat.com>
Date: Wed, 28 Mar 2018 13:16:10 -0400
MIME-Version: 1.0
In-Reply-To: <CAMxuvawv2Q13Ge=Pim3Uy9JG65rQaCU2CCHZav6jsPirUdqmAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] blockjob: leak fix,
 remove from txn when failing early
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, mreitz@redhat.com, "Wolf, Kevin" <kwolf@redhat.com>



On 03/28/2018 10:28 AM, Marc-Andr=C3=A9 Lureau wrote:
> On Wed, Mar 28, 2018 at 4:09 PM, Jeff Cody <jcody@redhat.com> wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> This fixes leaks found by ASAN such as:
>>   GTESTER tests/test-blockjob
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =3D=3D31442=3D=3DERROR: LeakSanitizer: detected memory leaks
>>
>> Direct leak of 24 byte(s) in 1 object(s) allocated from:
>>     #0 0x7f88483cba38 in __interceptor_calloc (/lib64/libasan.so.4+0xd=
ea38)
>>     #1 0x7f8845e1bd77 in g_malloc0 ../glib/gmem.c:129
>>     #2 0x7f8845e1c04b in g_malloc0_n ../glib/gmem.c:360
>>     #3 0x5584d2732498 in block_job_txn_new /home/elmarco/src/qemu/bloc=
kjob.c:172
>>     #4 0x5584d2739b28 in block_job_create /home/elmarco/src/qemu/block=
job.c:973
>>     #5 0x5584d270ae31 in mk_job /home/elmarco/src/qemu/tests/test-bloc=
kjob.c:34
>>     #6 0x5584d270b1c1 in do_test_id /home/elmarco/src/qemu/tests/test-=
blockjob.c:57
>>     #7 0x5584d270b65c in test_job_ids /home/elmarco/src/qemu/tests/tes=
t-blockjob.c:118
>>     #8 0x7f8845e40b69 in test_case_run ../glib/gtestutils.c:2255
>>     #9 0x7f8845e40f29 in g_test_run_suite_internal ../glib/gtestutils.=
c:2339
>>     #10 0x7f8845e40fd2 in g_test_run_suite_internal ../glib/gtestutils=
.c:2351
>>     #11 0x7f8845e411e9 in g_test_run_suite ../glib/gtestutils.c:2426
>>     #12 0x7f8845e3fe72 in g_test_run ../glib/gtestutils.c:1692
>>     #13 0x5584d270d6e2 in main /home/elmarco/src/qemu/tests/test-block=
job.c:377
>>     #14 0x7f8843641f29 in __libc_start_main (/lib64/libc.so.6+0x20f29)
>>
>> Add an assert to make sure that the job doesn't have associated txn be=
fore free().
>>
>> [Jeff Cody: N.B., used updated patch provided by John Snow]
>=20
> Looks good to me, so :)
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> thanks

Thanks for catching it!
