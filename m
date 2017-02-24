Received: from eggs.gnu.org ([2001:4830:134:3::10]:60667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1chHpy-00074C-Hn
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:31:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1chHpu-0007xd-Ji
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:31:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1chHpu-0007x1-Dp
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:31:10 -0500
References: <1486041504-23627-1-git-send-email-den@openvz.org>
	<CAJ+F1CL06FJvVrSmLE4-p208ocFoP7d-w_7mBkOmvnTrBxA5qQ@mail.gmail.com>
	<871sunzovz.fsf@dusky.pond.sub.org>
	<CAJ+F1CJZUW8jTnCYQ7RDsRHK3fmucRVZMr2uDm62Esjdrcn6sw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06eccfa8-6a4e-a892-576a-ac06e61a0e2f@redhat.com>
Date: Fri, 24 Feb 2017 16:31:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJZUW8jTnCYQ7RDsRHK3fmucRVZMr2uDm62Esjdrcn6sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qemu-char: socket backend:
 disconnect on write error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>



On 24/02/2017 15:46, Marc-Andr=C3=A9 Lureau wrote:
>=20
>>> +        if (ret < 0 && errno !=3D EAGAIN) {
>>> +            if (tcp_chr_read_poll(chr) <=3D 0) {
>>> +                tcp_chr_disconnect(chr);
>>> +                return len;
>>>
>>
>> This change breaks a number of assumption in vhost-user code. Until no=
w, a
>> vhost-user function assumed that dev->vhost_ops would remain as long a=
s the
>> function is running, so it may call vhost_ops callbacks several time, =
which
>> may eventually fail to do io, but no crash would occur. The disconnect=
ion
>> would be handled later with the HUP handler. Now, vhost_ops may be cle=
ared
>> during a write (chr_disconnect -> CHR_EVENT_CLOSED in
>> net_vhost_user_event). This can be randomly reproduced with
>> vhost-user-test -p /x86_64/vhost-user/flags-mismatch/subprocess

Would it work to call tcp_chr_disconnect from an idle source (and
destroy the source on the next connect)?

Paolo
