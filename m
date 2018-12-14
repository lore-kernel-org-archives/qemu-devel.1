Received: from eggs.gnu.org ([2001:4830:134:3::10]:35086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gXjaO-0008TT-7B
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gXjaJ-0002u9-RC
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:16:43 -0500
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:51667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gXjaJ-0002i5-HO
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:16:39 -0500
Received: by mail-it1-x143.google.com with SMTP id x19so7990226itl.1
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 01:16:30 -0800 (PST)
MIME-Version: 1.0
References: <1544701071-2922-1-git-send-email-liq3ea@gmail.com>
	<154471686589.17726.17792356837247129570@02a1dbf831e2>
	<CAKXe6SLLrFDCaqBW8B_qBmcrYm6HM9jzv5C2VNyph+218sMeWA@mail.gmail.com>
In-Reply-To: <CAKXe6SLLrFDCaqBW8B_qBmcrYm6HM9jzv5C2VNyph+218sMeWA@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 14 Dec 2018 17:15:52 +0800
Message-ID: <CAKXe6S+S4dsKkk-FGQeaXQgT6p=ijMojtMiHHNd9ss54etg03Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] util: check the return value of fcntl
 in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>, marcandre lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, mst@redhat.com, Jason Wang <jasowang@redhat.com>

Li Qiang <liq3ea@gmail.com> =E4=BA=8E2018=E5=B9=B412=E6=9C=8814=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=889:46=E5=86=99=E9=81=93=EF=BC=9A

> Hi all,
>
> Here is the error.
>
>   GTESTER check-qtest-x86_64
> Unable to get file status flag on fd 21860: Bad file descriptor(errno=3D9=
)
>   GTESTER check-qtest-aarch64
> Broken pipe
> GTester: last random seed: R02S3f0d6981dd97231d06e0b2966baf94b9
> Unable to get file status flag on fd 21965: Bad file descriptor(errno=3D9=
)
> Broken pipe
> GTester: last random seed: R02S29fde958e7ee4c26c4f295ff4dbd47d4
> Unable to get file status flag on fd 21890: Bad file descriptor(errno=3D9=
)
> Broken pipe
> GTester: last random seed: R02S6d074187e5c8501255c96b247f5c8e3f
> Unable to get file status flag on fd 21923: Bad file descriptor(errno=3D9=
)
> Broken pipe
> GTester: last random seed: R02S446127f38eb9e8b4f181e6fc95026ba0
>   GTESTER tests/test-qht-par
> Could not access KVM kernel module: No such file or directory
>
>
> The fd '21860' '21965', '21890', '21923' is a little strange. Following i=
s
> my guess.
>
> 21280 --> 0x5564
> 21965 --> 0x55CD
> 21890 --> 0x5582
> 21923 --> 0x55A3
>
> Seems they are stack uninitialized value which 'fd's memory holds.
> Seems 'qemu_chr_fe_get_msgfds' first failed, then the 'fd' is an
> uninitialized value
> cause my first patch 'assert' fails.
>
>

First of all I want to know does the following error means?
doesn't it mean "the x86 qtest is ok and aarch64 is not ok"?


  GTESTER check-qtest-x86_64
  GTESTER check-qtest-aarch64
vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245:
qemu_set_nonblock: Assertion `f !=3D -1' failed.
Broken pipe
GTester: last random seed: R02S61a1e35369394d7efb0a0e96d8af615d
  GTESTER tests/test-qht-par
vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245:
qemu_set_nonblock: Assertion `f !=3D -1' failed.
Broken pipe
GTester: last random seed: R02Sbf8c21ef5f216840e073ff3e487dedbc
vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245:
qemu_set_nonblock: Assertion `f !=3D -1' failed.
Broken pipe
GTester: last random seed: R02Sfe8cd276fddf3a92891cf274bf88e888
vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245:
qemu_set_nonblock: Assertion `f !=3D -1' failed.
Broken pipe
GTester: last random seed: R02S7487fc065e22541ba4c78c0db6c61d3c
Could not access KVM kernel module: No such file or directory


This issue is caused by 'chr_read' in vhost-user-test.c processes
'VHOST_USER_SET_VRING_CALL'.
qemu_chr_fe_get_msgfds->tcp_get_msgfds

static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
{
    SocketChardev *s =3D SOCKET_CHARDEV(chr);

    int to_copy =3D (s->read_msgfds_num < num) ? s->read_msgfds_num : num;

    assert(num <=3D TCP_MAX_FDS);

    if (to_copy) {
        int i;

        memcpy(fds, s->read_msgfds, to_copy * sizeof(int));

        /* Close unused fds */
        for (i =3D to_copy; i < s->read_msgfds_num; i++) {
            close(s->read_msgfds[i]);
        }

        g_free(s->read_msgfds);
        s->read_msgfds =3D 0;
        s->read_msgfds_num =3D 0;
    }

    return to_copy;
}

The 's->read_msgfds_num' is 0, so qemu_chr_fe_get_msgfds returns 0, and
'fd' be an uninitialized stack value.

The reason why 's->read_msgfds_num' is 0 is that in 'vhost_set_vring_file'.
the 'ioeventfd_enabled()' returns 0 and 'kvm_eventfds_allowed' is 0 which
means the
kernel doesn't support eventfd.

static int vhost_set_vring_file(struct vhost_dev *dev,
                                VhostUserRequest request,
                                struct vhost_vring_file *file)
{

    if (ioeventfd_enabled() && file->fd > 0) {
        fds[fd_num++] =3D file->fd;
    } else {
        msg.payload.u64 |=3D VHOST_USER_VRING_NOFD_MASK;
    }
  ...
    return 0;
}



After I look at the kernel, the arm platform seems doesn't support eventfd.

So if my understanding is correct in the first, '"the x86 qtest is ok and
aarch64 is not ok".
This can be explainable. But if not, there maybe another issue.

Since this is related with vhost-user-test, Cc Jason and Michael .

Thanks,
Li Qiang



> Thanks,
> Li Qiang
>
>
>
> <no-reply@patchew.org> =E4=BA=8E2018=E5=B9=B412=E6=9C=8814=E6=97=A5=E5=91=
=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:01=E5=86=99=E9=81=93=EF=BC=9A
>
>> Patchew URL:
>> https://patchew.org/QEMU/1544701071-2922-1-git-send-email-liq3ea@gmail.c=
om/
>>
>>
>>
>> Hi,
>>
>> This series failed the docker-quick@centos7 build test. Please find the
>> testing commands and
>> their output below. If you have Docker installed, you can probably
>> reproduce it
>> locally.
>>
>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/bash
>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D8
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>
>> libpmem support   no
>> libudev           no
>>
>> WARNING: Use of SDL 1.2 is deprecated and will be removed in
>> WARNING: future releases. Please switch to using SDL 2.0
>>
>> NOTE: cross-compilers enabled:  'cc'
>>   GEN     x86_64-softmmu/config-devices.mak.tmp
>>
>>
>> The full log is available at
>>
>> http://patchew.org/logs/1544701071-2922-1-git-send-email-liq3ea@gmail.co=
m/testing.docker-quick@centos7/?type=3Dmessage
>> .
>> ---
>> Email generated automatically by Patchew [http://patchew.org/].
>> Please send your feedback to patchew-devel@redhat.com
>
>
