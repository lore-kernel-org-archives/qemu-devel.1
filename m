Received: from eggs.gnu.org ([209.51.188.92]:40264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmx9Y-0002Hp-FR
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 03:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmx6E-0005sj-VK
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 03:44:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gmx6B-0005rL-6u
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 03:44:29 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
	<fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
	<CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
	<64411f3f-0071-fc94-945c-af16cf5edc77@redhat.com>
	<20190123195345.GI2193@work-vm>
	<a0c711c1-17d4-9fbe-b78c-4cd4a2419633@redhat.com>
	<877eeuidzp.fsf@dusky.pond.sub.org>
	<9cbb73bc-dbe2-4f5b-56e4-4c733811ed54@redhat.com>
	<87a7jptdla.fsf@dusky.pond.sub.org>
	<c5c6c8cb-0cfd-323e-a291-f098ea4b8ec2@redhat.com>
Date: Fri, 25 Jan 2019 09:44:16 +0100
In-Reply-To: <c5c6c8cb-0cfd-323e-a291-f098ea4b8ec2@redhat.com> (Jason Wang's
	message of "Fri, 25 Jan 2019 16:12:24 +0800")
Message-ID: <87womtqg7z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Jason Wang <jasowang@redhat.com> writes:

> On 2019/1/25 =E4=B8=8B=E5=8D=883:12, Markus Armbruster wrote:
>> Jason Wang <jasowang@redhat.com> writes:
>>
>>> On 2019/1/24 =E4=B8=8B=E5=8D=885:47, Markus Armbruster wrote:
>>>> Please cc: me on QMP issues.
>>>
>>> Ok.
>>>
>>>
>>>> Jason Wang <jasowang@redhat.com> writes:
>>>>
>>>>> On 2019/1/24 =E4=B8=8A=E5=8D=883:53, Dr. David Alan Gilbert wrote:
>>>>>> * Jason Wang (jasowang@redhat.com) wrote:
>>>>>>> On 2019/1/22 =E4=B8=8A=E5=8D=882:56, Peter Maydell wrote:
>>>>>>>> On Thu, 17 Jan 2019 at 09:46, Jason Wang<jasowang@redhat.com>  wro=
te:
>>>>>>>>> On 2019/1/15 =E4=B8=8A=E5=8D=8812:33, Zhang Chen wrote:
>>>>>>>>>> On Sat, Jan 12, 2019 at 12:15 AM Dr. David Alan Gilbert
>>>>>>>>>> <dgilbert@redhat.com  <mailto:dgilbert@redhat.com>> wrote:
>>>>>>>>>>
>>>>>>>>>>         * Peter Maydell (peter.maydell@linaro.org
>>>>>>>>>>         <mailto:peter.maydell@linaro.org>) wrote:
>>>>>>>>>>         > Recently I've noticed that test-filter-mirror has been=
 hanging
>>>>>>>>>>         > intermittently, typically when run on some other TCG a=
rchitecture.
>>>>>>>>>>         > In the instance I've just looked at, this was with s39=
0x guest on
>>>>>>>>>>         > x86-64 host, though I've also seen it on other host ar=
chs and
>>>>>>>>>>         > perhaps with other guests.
>>>>>>>>>>
>>>>>>>>>>         Watch out to see if you really do see it for other guest=
s;
>>>>>>>>>>         it carefully avoids using virtio-net to avoid vhost; but=
 on s390x it
>>>>>>>>>>         uses virtio-net-ccw - could that hit the vhost it was tr=
ying to avoid?
>>>>>>>>>>
>>>>>>>>>>         > Below is a backtrace, though it seems to be pretty unh=
elpful.
>>>>>>>>>>         > Anybody got any theories ? Does the mirror test rely o=
n dirty
>>>>>>>>>>         > memory bitmaps like the migration test (which also han=
gs
>>>>>>>>>>         > occasionally with TCG due to some bug I'm sure we've i=
nvestigated
>>>>>>>>>>         > in the past) ?
>>>>>>>>>>
>>>>>>>>>>         I don't think it relies on the CPU at all.
>>>>>>>>>>      I have no idea about this currently, but Jason and I design=
ed the
>>>>>>>>>> test case.
>>>>>>>>>> Add Jason: Have any comments about this ?
>>>>>>>>> I can't reproduce this locally with s390x-softmmu. It looks to me=
 the
>>>>>>>>> test should be independent to any kinds of emulation. It should p=
ass
>>>>>>>>> when mainloop work.
>>>>>>>> I've just seen a hang with ppc64 guest on s390x host, so it is
>>>>>>>> indeed not specific to s390x guest (and so not specific to
>>>>>>>> virtio-net either, since the ppc64 guest setup uses e1000).
>>>>>>>>
>>>>>>>> thanks
>>>>>>>> -- PMM
>>>>>>> Finally reproduced locally after hundreds (sometimes thousands) tim=
es of
>>>>>>> running.
>>>>>>>
>>>>>>> Bisection points to OOB monitor[1].
>>>>>>>
>>>>>>> It looks to me after OOB is used unconditionally we lose a barrier =
to make
>>>>>>> sure socket is connected before sending packets in test-filter-mirr=
or.c. Is
>>>>>>> there any other similar and simple thing that we could do to kick t=
he
>>>>>>> mainloop?
>>>>>> Do you mean the:
>>>>>>
>>>>>>        /* send a qmp command to guarantee that 'connected' is settin=
g to true. */
>>>>>>        qmp_discard_response(qts, "{ 'execute' : 'query-status'}");
>>>>> Yes.
>>>>>
>>>>>
>>>>>> why was that ever sufficient to know the socket was ready?
>>>>> It was suggested by Fam, I don't remember the details. Can we make
>>>>> sure all pending events has been processed (UNIX socket was set to
>>>>> connected) after query-status is returned with an non OOB monitor?
>>>> I'm afraid I lack context.  Which socket are you talking about?  The
>>>> test has at least the QMP socket, the send_sock[], and recv_sock.  What
>>>> exactly are you trying to accomplish?
>>>
>>> I mean recv_sock. If mirror tries to send a packet to it before its
>>> is_connected is set to true, packet will be dropped.
>> So the *socket* is connected (in the TCP sense),
>
>
> UNIX domain socket actually in the case of this test.

Yes.

>> but something else
>> (whatever owns is_connected) is not.  Can you point me to where
>> is_connected is set to true?
>
>
> Sorry, should be "connected". It was set in tcp_chr_connect(). So if
> filter want to send a packet to socket chardev before
> tcp_chr_connect() is called, the packet will be dropped silently by
> tcp_chr_write(). This will fail this unit-test.

Aha: the thing that isn't connected is the character device.

>>>> By the way, mkstemp(sock_path) followed by unix_connect(sock_path, NUL=
L)
>>>> looks rather fishy.  Why create a temporary file only to create a Unix
>>>> domain socket right over it?
>>>
>>> I vaguely remember passing fd created by unix domain socket doesn't
>>> work when the test is introduced. So my understanding is the author
>>> needs a way to create a unique file name which will be used b Unix
>>> domain socket at that time.
>> We should really, really, really improve the test harness to run each
>> test program in its very own temporary directory.  Then tests can simply
>> create files with fixed names, and leave cleanup to the test harness.
>
>
> Agree, but for this test, since passing fd works now. I tend to using
> socketpair().

Resources that don't require manual cleanup (such as file descriptors
obtained with socketpair() or pipe()) are the best choice when they
work.

[..]
