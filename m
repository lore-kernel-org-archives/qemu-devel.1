Received: from eggs.gnu.org ([209.51.188.92]:42179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gm8Vw-00087I-Fq
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 21:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gm8Vu-0003f8-JP
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 21:43:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gm8Vs-0003Zf-Bj
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 21:43:36 -0500
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
	<fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
	<CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <64411f3f-0071-fc94-945c-af16cf5edc77@redhat.com>
Date: Wed, 23 Jan 2019 10:43:11 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] test-filter-mirror hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>


On 2019/1/22 =E4=B8=8A=E5=8D=882:56, Peter Maydell wrote:
> On Thu, 17 Jan 2019 at 09:46, Jason Wang <jasowang@redhat.com> wrote:
>>
>> On 2019/1/15 =E4=B8=8A=E5=8D=8812:33, Zhang Chen wrote:
>>>
>>> On Sat, Jan 12, 2019 at 12:15 AM Dr. David Alan Gilbert
>>> <dgilbert@redhat.com <mailto:dgilbert@redhat.com>> wrote:
>>>
>>>      * Peter Maydell (peter.maydell@linaro.org
>>>      <mailto:peter.maydell@linaro.org>) wrote:
>>>      > Recently I've noticed that test-filter-mirror has been hanging
>>>      > intermittently, typically when run on some other TCG architect=
ure.
>>>      > In the instance I've just looked at, this was with s390x guest=
 on
>>>      > x86-64 host, though I've also seen it on other host archs and
>>>      > perhaps with other guests.
>>>
>>>      Watch out to see if you really do see it for other guests;
>>>      it carefully avoids using virtio-net to avoid vhost; but on s390=
x it
>>>      uses virtio-net-ccw - could that hit the vhost it was trying to =
avoid?
>>>
>>>      > Below is a backtrace, though it seems to be pretty unhelpful.
>>>      > Anybody got any theories ? Does the mirror test rely on dirty
>>>      > memory bitmaps like the migration test (which also hangs
>>>      > occasionally with TCG due to some bug I'm sure we've investiga=
ted
>>>      > in the past) ?
>>>
>>>      I don't think it relies on the CPU at all.
>>>   I have no idea about this currently, but Jason and I designed the
>>> test case.
>>> Add Jason: Have any comments about this ?
>>
>> I can't reproduce this locally with s390x-softmmu. It looks to me the
>> test should be independent to any kinds of emulation. It should pass
>> when mainloop work.
> I've just seen a hang with ppc64 guest on s390x host, so it is
> indeed not specific to s390x guest (and so not specific to
> virtio-net either, since the ppc64 guest setup uses e1000).
>
> thanks
> -- PMM


Finally reproduced locally after hundreds (sometimes thousands) times of=20
running.

Bisection points to OOB monitor[1].

It looks to me after OOB is used unconditionally we lose a barrier to=20
make sure socket is connected before sending packets in=20
test-filter-mirror.c. Is there any other similar and simple thing that=20
we could do to kick the mainloop?

Thanks

[1]

commit 8258292e18c39480b64eba9f3551ab772ce29b5d (HEAD, refs/bisect/bad)
Author: Peter Xu <peterx@redhat.com>
Date:=C2=A0=C2=A0 Tue Oct 9 14:27:15 2018 +0800

 =C2=A0=C2=A0=C2=A0 monitor: Remove "x-oob", offer capability "oob" uncon=
ditionally

 =C2=A0=C2=A0=C2=A0 Out-of-band command execution was introduced in commi=
t cf869d53172.
 =C2=A0=C2=A0=C2=A0 Unfortunately, we ran into a regression, and had to t=
urn it into an
 =C2=A0=C2=A0=C2=A0 experimental option for 2.12 (commit be933ffc23).

http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html

 =C2=A0=C2=A0=C2=A0 The regression has since been fixed (commit 951702f39=
c7 "monitor: bind
 =C2=A0=C2=A0=C2=A0 dispatch bh to iohandler context").=C2=A0 A thorough =
re-review of OOB
 =C2=A0=C2=A0=C2=A0 commands led to a few more issues, which have also be=
en addressed.

 =C2=A0=C2=A0=C2=A0 This patch partly reverts be933ffc23 (monitor: new pa=
rameter "x-oob"),
 =C2=A0=C2=A0=C2=A0 and makes QMP monitors again offer capability "oob" w=
henever they can
 =C2=A0=C2=A0=C2=A0 provide it, i.e. when the monitor's character device =
is capable of
 =C2=A0=C2=A0=C2=A0 running in an I/O thread.

 =C2=A0=C2=A0=C2=A0 Some trivial touch-up in the test code is required to=
 make sure=20
qmp-test
 =C2=A0=C2=A0=C2=A0 won't break.

 =C2=A0=C2=A0=C2=A0 Reviewed-by: Markus Armbruster <armbru@redhat.com>
 =C2=A0=C2=A0=C2=A0 Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau=
@redhat.com>
 =C2=A0=C2=A0=C2=A0 Signed-off-by: Peter Xu <peterx@redhat.com>
 =C2=A0=C2=A0=C2=A0 Message-Id: <20181009062718.1914-4-peterx@redhat.com>
 =C2=A0=C2=A0=C2=A0 [Conflict with "monitor: check if chardev can switch =
gcontext for OOB"
 =C2=A0=C2=A0=C2=A0 resolved, commit message updated]
 =C2=A0=C2=A0=C2=A0 Signed-off-by: Markus Armbruster <armbru@redhat.com>
