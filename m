Received: from eggs.gnu.org ([209.51.188.92]:36603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1goJWK-0004Zr-7M
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 21:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1goJWJ-0006sv-7T
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 21:53:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1goJWI-0006sX-VX
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 21:53:03 -0500
References: <20190128041159.28643-1-jasowang@redhat.com>
	<20190128103048.GA15071@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c4414b41-2fef-a405-6ac1-43c66a8bf998@redhat.com>
Date: Tue, 29 Jan 2019 10:52:50 +0800
MIME-Version: 1.0
In-Reply-To: <20190128103048.GA15071@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] test-filter-mirror: pass UNIX domain
 socket through fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Zhang Chen <zhangckid@gmail.com>


On 2019/1/28 =E4=B8=8B=E5=8D=886:30, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Jan 28, 2019 at 12:11:59PM +0800, Jason Wang wrote:
>> The tests tries to let qemu server mode to process the connection
>> which turns out to be racy after commit 8258292e18c3 ("monitor: Remove
>> "x-oob", offer capability "oob" unconditionally"). This is because the
>> filter may try to mirror the packets before UNIX socket object is
>> ready (connected was set to true) from the view of qemu. In this case
>> the packet will be dropped silently.
>>
>> Fixing this by passing pre-connected socket created by socketpair() to
>> qemu through fd.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Zhang Chen <zhangckid@gmail.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Daniel P. Berrange <berrange@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   tests/test-filter-mirror.c | 18 ++++++------------
>>   1 file changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
>> index 7ab2aed8a0..3c3d1f8961 100644
>> --- a/tests/test-filter-mirror.c
>> +++ b/tests/test-filter-mirror.c
>> @@ -21,10 +21,9 @@
>>  =20
>>   static void test_mirror(void)
>>   {
>> -    int send_sock[2], recv_sock;
>> +    int send_sock[2], recv_sock[2];
>>       uint32_t ret =3D 0, len =3D 0;
>>       char send_buf[] =3D "Hello! filter-mirror~";
>> -    char sock_path[] =3D "filter-mirror.XXXXXX";
>>       char *recv_buf;
>>       uint32_t size =3D sizeof(send_buf);
>>       size =3D htonl(size);
>> @@ -38,18 +37,15 @@ static void test_mirror(void)
>>       ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, send_sock);
>>       g_assert_cmpint(ret, !=3D, -1);
>>  =20
>> -    ret =3D mkstemp(sock_path);
>> +    ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, recv_sock);
>>       g_assert_cmpint(ret, !=3D, -1);
>>  =20
>>       qts =3D qtest_initf(
>>           "-netdev socket,id=3Dqtest-bn0,fd=3D%d "
>>           "-device %s,netdev=3Dqtest-bn0,id=3Dqtest-e0 "
>> -        "-chardev socket,id=3Dmirror0,path=3D%s,server,nowait "
>> +        "-chardev socket,id=3Dmirror0,fd=3D%d "
>>           "-object filter-mirror,id=3Dqtest-f0,netdev=3Dqtest-bn0,queu=
e=3Dtx,outdev=3Dmirror0 "
>> -        , send_sock[1], devstr, sock_path);
>> -
>> -    recv_sock =3D unix_connect(sock_path, NULL);
>> -    g_assert_cmpint(recv_sock, !=3D, -1);
>> +        , send_sock[1], devstr, recv_sock[1]);
>>  =20
>>       struct iovec iov[] =3D {
>>           {
>> @@ -67,18 +63,16 @@ static void test_mirror(void)
>>       g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
>>       close(send_sock[0]);
>>  =20
>> -    ret =3D qemu_recv(recv_sock, &len, sizeof(len), 0);
>> +    ret =3D qemu_recv(recv_sock[0], &len, sizeof(len), 0);
>>       g_assert_cmpint(ret, =3D=3D, sizeof(len));
>>       len =3D ntohl(len);
>>  =20
>>       g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
>>       recv_buf =3D g_malloc(len);
>> -    ret =3D qemu_recv(recv_sock, recv_buf, len, 0);
>> +    ret =3D qemu_recv(recv_sock[0], recv_buf, len, 0);
>>       g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
>>  =20
>>       g_free(recv_buf);
>> -    close(recv_sock);
> You're leaking recv_sock[0] and recv_sock[1] now. For that matter it
> seems send_sock[0] & send_sock[1] are already both leaked too.


Will fix in V2.

Thanks


>> -    unlink(sock_path);
>>       qtest_quit(qts);
>>   }
> Regards,
> Daniel
