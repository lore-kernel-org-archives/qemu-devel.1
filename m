Received: from eggs.gnu.org ([2001:4830:134:3::10]:56593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diLNT-0007PQ-2Y
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diLNO-0005lb-WB
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:02:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diLNO-0005lA-Mb
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:02:22 -0400
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-3-git-send-email-thuth@redhat.com>
	<20170817104122.4d72674b.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <98d06e4e-b0e9-9a44-195a-3aab6f3cf219@redhat.com>
Date: Thu, 17 Aug 2017 16:02:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170817104122.4d72674b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] tests: Add network filter tests to the
 check-qtest-s390x list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Yang Hongyang <yanghy@cn.fujitsu.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

On 17.08.2017 10:41, Cornelia Huck wrote:
> On Thu, 17 Aug 2017 08:25:09 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> With some small modifications, we can also use the the netfilter,
>> the fiter-mirror and the filter-redirector tests on s390x.
>=20
> s/fiter/filter/

OK ... could you please fix that when picking up the patch (in case I do
not have to resend)?

>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/Makefile.include         |  3 +++
>>  tests/test-filter-mirror.c     |  9 +++++++--
>>  tests/test-filter-redirector.c | 22 ++++++++++++++++------
>>  tests/test-netfilter.c         | 11 ++++++++++-
>>  4 files changed, 36 insertions(+), 9 deletions(-)
>>
>=20
>> diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
>> index a1d5865..d569d27 100644
>> --- a/tests/test-filter-mirror.c
>> +++ b/tests/test-filter-mirror.c
>> @@ -25,6 +25,11 @@ static void test_mirror(void)
>>      char *recv_buf;
>>      uint32_t size =3D sizeof(send_buf);
>>      size =3D htonl(size);
>> +    const char *devstr =3D "e1000";
>> +
>> +    if (g_str_equal(qtest_get_arch(), "s390x")) {
>> +        devstr =3D "virtio-net-ccw";
>> +    }
>=20
> I'm wondering if we could unify selection of the network device
> somehow. There's probably two cases:
> - Test a specific device. This obviously needs to be decided
>   individually.
> - Just use a functional network device. For s390x, this will be
>   virtio-net-ccw; for other architectures, this test uses e1000, while
>   one of the tests below uses rtl8139 (why?). A helper for that may be
>   useful.

Maybe ... OTOH, this likely increases also test coverage if we do not
use the same PCI NIC in all the tests...?

>> =20
>>      ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, send_sock);
>>      g_assert_cmpint(ret, !=3D, -1);
>=20
>> diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redire=
ctor.c
>> index 69c663b..3afd411 100644
>> --- a/tests/test-filter-redirector.c
>> +++ b/tests/test-filter-redirector.c
>> @@ -57,6 +57,16 @@
>>  #include "qemu/error-report.h"
>>  #include "qemu/main-loop.h"
>> =20
>> +static const char *get_devstr(void)
>> +{
>> +    if (g_str_equal(qtest_get_arch(), "s390x")) {
>> +        return "virtio-net-ccw";
>> +    }
>> +
>> +    return "rtl8139";
>=20
> No problem with your patch, but I'm wondering why this does not use
> e1000. Special capabilities of rtl8139?

Maybe Zhang Chen can answer that question? (Now on CC: - forgot to do
that initially, sorry!)
But I guess it's just an arbitrary NIC that works on most of the
platforms (i.e. a normal PCI NIC)...?

>> +}
>> +
>> +
>>  static void test_redirector_tx(void)
>>  {
>>      int backend_sock[2], recv_sock;
>=20
>> diff --git a/tests/test-netfilter.c b/tests/test-netfilter.c
>> index 8b5a9b2..2506473 100644
>> --- a/tests/test-netfilter.c
>> +++ b/tests/test-netfilter.c
>> @@ -182,6 +182,12 @@ static void remove_netdev_with_multi_netfilter(vo=
id)
>>  int main(int argc, char **argv)
>>  {
>>      int ret;
>> +    char *args;
>> +    const char *devstr =3D "e1000";
>=20
> It's our old friend again :)
>=20
>> +
>> +    if (g_str_equal(qtest_get_arch(), "s390x")) {
>> +        devstr =3D "virtio-net-ccw";
>> +    }
>> =20
>>      g_test_init(&argc, &argv, NULL);
>>      qtest_add_func("/netfilter/addremove_one", add_one_netfilter);
>> @@ -191,10 +197,13 @@ int main(int argc, char **argv)
>>      qtest_add_func("/netfilter/remove_netdev_multi",
>>                     remove_netdev_with_multi_netfilter);
>> =20
>> -    qtest_start("-netdev user,id=3Dqtest-bn0 -device e1000,netdev=3Dq=
test-bn0");
>> +    args =3D g_strdup_printf("-netdev user,id=3Dqtest-bn0 "
>> +                           "-device %s,netdev=3Dqtest-bn0", devstr);
>> +    qtest_start(args);
>>      ret =3D g_test_run();
>> =20
>>      qtest_end();
>> +    g_free(args);
>> =20
>>      return ret;
>>  }
>=20
> Even though I think we should deal with the questions above, having
> more tests for s390x is certainly a good idea. Thus,
>=20
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks for the review,
 Thomas
