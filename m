Received: from eggs.gnu.org ([2001:4830:134:3::10]:52874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPWhg-0007cR-AK
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPWha-0006Lq-E4
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:54:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gPWhY-0006G7-DR
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:54:14 -0500
References: <20181109173028.3372-1-marcandre.lureau@redhat.com>
	<CAJ+F1CLH1KGa5OZ1Jsg8+-5KFYePD-SHnVqF-0eb0TqC9xhu0Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d935f260-1dad-4e22-ae4b-1c2186fe3815@redhat.com>
Date: Wed, 21 Nov 2018 18:53:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLH1KGa5OZ1Jsg8+-5KFYePD-SHnVqF-0eb0TqC9xhu0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user-bridge: fix recvmsg iovlen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>
Cc: Victor Kaplansky <victork@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 15/11/18 12:45, Marc-Andr=C3=A9 Lureau wrote:
> On Fri, Nov 9, 2018 at 9:39 PM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>>
>> After iov_discard_front(), the iov may be smaller than its initial
>> size. Fixes the heap-buffer-overflow spotted by ASAN:
>>
>> =3D=3D9036=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on addre=
ss 0x6060000001e0 at pc 0x7fe632eca3f0 bp 0x7ffddc4a05a0 sp 0x7ffddc49fd4=
8
>> WRITE of size 32 at 0x6060000001e0 thread T0
>>     #0 0x7fe632eca3ef  (/lib64/libasan.so.5+0x773ef)
>>     #1 0x7fe632ecad23 in __interceptor_recvmsg (/lib64/libasan.so.5+0x=
77d23)
>>     #2 0x561e7491936b in vubr_backend_recv_cb /home/elmarco/src/qemu/t=
ests/vhost-user-bridge.c:333
>>     #3 0x561e74917711 in dispatcher_wait /home/elmarco/src/qemu/tests/=
vhost-user-bridge.c:160
>>     #4 0x561e7491c3b5 in vubr_run /home/elmarco/src/qemu/tests/vhost-u=
ser-bridge.c:725
>>     #5 0x561e7491c85c in main /home/elmarco/src/qemu/tests/vhost-user-=
bridge.c:806
>>     #6 0x7fe631a6c412 in __libc_start_main (/lib64/libc.so.6+0x24412)
>>     #7 0x561e7491667d in _start (/home/elmarco/src/qemu/build/tests/vh=
ost-user-bridge+0x3967d)
>>
>> 0x6060000001e0 is located 0 bytes to the right of 64-byte region [0x60=
60000001a0,0x6060000001e0)
>> allocated by thread T0 here:
>>     #0 0x7fe632f42848 in __interceptor_malloc (/lib64/libasan.so.5+0xe=
f848)
>>     #1 0x561e7493acd8 in virtqueue_alloc_element /home/elmarco/src/qem=
u/contrib/libvhost-user/libvhost-user.c:1848
>>     #2 0x561e7493c2a8 in vu_queue_pop /home/elmarco/src/qemu/contrib/l=
ibvhost-user/libvhost-user.c:1954
>>     #3 0x561e749189bf in vubr_backend_recv_cb /home/elmarco/src/qemu/t=
ests/vhost-user-bridge.c:297
>>     #4 0x561e74917711 in dispatcher_wait /home/elmarco/src/qemu/tests/=
vhost-user-bridge.c:160
>>     #5 0x561e7491c3b5 in vubr_run /home/elmarco/src/qemu/tests/vhost-u=
ser-bridge.c:725
>>     #6 0x561e7491c85c in main /home/elmarco/src/qemu/tests/vhost-user-=
bridge.c:806
>>     #7 0x7fe631a6c412 in __libc_start_main (/lib64/libc.so.6+0x24412)
>>
>> SUMMARY: AddressSanitizer: heap-buffer-overflow (/lib64/libasan.so.5+0=
x773ef)
>> Shadow bytes around the buggy address:
>>   0x0c0c7fff7fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   0x0c0c7fff7ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   0x0c0c7fff8000: fa fa fa fa 00 00 00 00 00 00 05 fa fa fa fa fa
>>   0x0c0c7fff8010: 00 00 00 00 00 00 00 00 fa fa fa fa fd fd fd fd
>>   0x0c0c7fff8020: fd fd fd fd fa fa fa fa fd fd fd fd fd fd fd fd
>> =3D>0x0c0c7fff8030: fa fa fa fa 00 00 00 00 00 00 00 00[fa]fa fa fa
>>   0x0c0c7fff8040: fd fd fd fd fd fd fd fd fa fa fa fa fd fd fd fd
>>   0x0c0c7fff8050: fd fd fd fd fa fa fa fa fd fd fd fd fd fd fd fd
>>   0x0c0c7fff8060: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>>   0x0c0c7fff8070: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>>   0x0c0c7fff8080: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> ping
>=20
>> ---
>>  tests/vhost-user-bridge.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
>> index a07ce0f917..0033b61f2e 100644
>> --- a/tests/vhost-user-bridge.c
>> +++ b/tests/vhost-user-bridge.c
>> @@ -323,7 +323,7 @@ vubr_backend_recv_cb(int sock, void *ctx)
>>              .msg_name =3D (struct sockaddr *) &vubr->backend_udp_dest=
,
>>              .msg_namelen =3D sizeof(struct sockaddr_in),
>>              .msg_iov =3D sg,
>> -            .msg_iovlen =3D elem->in_num,
>> +            .msg_iovlen =3D num,
>>              .msg_flags =3D MSG_DONTWAIT,
>>          };
>>          do {
>> --
>> 2.19.1.708.g4ede3d42df
>>
>>
>=20
>=20

Queued, thanks.

Paolo
