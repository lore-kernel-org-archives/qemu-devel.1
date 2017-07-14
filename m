Received: from eggs.gnu.org ([2001:4830:134:3::10]:41304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVte1-0004zO-T4
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVtdx-0003Oa-8v
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:00:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVtdw-0003Nt-Ju
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:00:01 -0400
References: <1499964378-24344-1-git-send-email-mst@redhat.com>
	<c491c6ee-67ed-e7a0-4294-b128f63d6841@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <415ee774-cab4-f48a-c081-c2158de35b50@redhat.com>
Date: Fri, 14 Jul 2017 07:59:54 +0200
MIME-Version: 1.0
In-Reply-To: <c491c6ee-67ed-e7a0-4294-b128f63d6841@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: switch pxe and vm gen id tests to
 use kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Ben Warren <ben@skyportsystems.com>, Peter Maydell <peter.maydell@linaro.org>

On 13.07.2017 19:00, Paolo Bonzini wrote:
> On 13/07/2017 18:47, Michael S. Tsirkin wrote:
>> Speed up tests on host systems with kvm support.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Laurent Vivier <lvivier@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>
>> This is on top of my previous patch fixing vmgenid.
>>
>> PPC PXE test is reported to be especially slow - does anyone care to t=
ry
>> it and measure whether this helps?
>>
>>  tests/pxe-test.c     | 2 +-
>>  tests/vmgenid-test.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/pxe-test.c b/tests/pxe-test.c
>> index 34282d3..cf6e225 100644
>> --- a/tests/pxe-test.c
>> +++ b/tests/pxe-test.c
>> @@ -25,7 +25,7 @@ static void test_pxe_one(const char *params, bool ip=
v6)
>>  {
>>      char *args;
>> =20
>> -    args =3D g_strdup_printf("-machine accel=3Dtcg -nodefaults -boot =
order=3Dn "
>> +    args =3D g_strdup_printf("-machine accel=3Dkvm:tcg -nodefaults -b=
oot order=3Dn "
>>                             "-netdev user,id=3D" NETNAME ",tftp=3D./,b=
ootfile=3D%s,"
>>                             "ipv4=3D%s,ipv6=3D%s %s", disk, ipv6 ? "of=
f" : "on",
>>                             ipv6 ? "on" : "off", params);
>> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
>> index 0556ba2..6477dcc 100644
>> --- a/tests/vmgenid-test.c
>> +++ b/tests/vmgenid-test.c
>> @@ -132,7 +132,7 @@ static char disk[] =3D "tests/vmgenid-test-disk-XX=
XXXX";
>> =20
>>  static char *guid_cmd_strdup(const char *guid)
>>  {
>> -    return g_strdup_printf("-machine accel=3Dtcg "
>> +    return g_strdup_printf("-machine accel=3Dkvm:tcg "
>>                             "-device vmgenid,id=3Dtestvgid,guid=3D%s "
>>                             "-drive id=3Dhd0,if=3Dnone,file=3D%s,forma=
t=3Draw "
>>                             "-device ide-hd,drive=3Dhd0 ",
>=20
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

NACK.

It's not that simple. If you do it like this, you then suddenly get
these ugly '"kvm" accelerator not found' messages during "make check"
which we really should avoid.

Laurent suggested some better ideas a couple of months ago, but I think
the common sense was rather "unit tests should always use TCG" at that
point in time:

 https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg00400.html

Well, now that we've got the "--disable-tcg" configure option, we should
maybe start to reconsider that ;-)

So I'm fine with the patch if you also include Laurent's patch to shut
up the error message:

 https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg00395.html

 Thomas
