Received: from eggs.gnu.org ([209.51.188.92]:59210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gmsbU-0004ez-Gu
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 22:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gmsbT-00020K-Fv
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 22:56:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gmsbT-0001zl-5t
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 22:56:27 -0500
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
	<fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
	<CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
	<64411f3f-0071-fc94-945c-af16cf5edc77@redhat.com>
	<20190123195345.GI2193@work-vm>
	<a0c711c1-17d4-9fbe-b78c-4cd4a2419633@redhat.com>
	<877eeuidzp.fsf@dusky.pond.sub.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9cbb73bc-dbe2-4f5b-56e4-4c733811ed54@redhat.com>
Date: Fri, 25 Jan 2019 11:56:18 +0800
MIME-Version: 1.0
In-Reply-To: <877eeuidzp.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


On 2019/1/24 =E4=B8=8B=E5=8D=885:47, Markus Armbruster wrote:
> Please cc: me on QMP issues.


Ok.


>
> Jason Wang <jasowang@redhat.com> writes:
>
>> On 2019/1/24 =E4=B8=8A=E5=8D=883:53, Dr. David Alan Gilbert wrote:
>>> * Jason Wang (jasowang@redhat.com) wrote:
>>>> On 2019/1/22 =E4=B8=8A=E5=8D=882:56, Peter Maydell wrote:
>>>>> On Thu, 17 Jan 2019 at 09:46, Jason Wang<jasowang@redhat.com>  wrot=
e:
>>>>>> On 2019/1/15 =E4=B8=8A=E5=8D=8812:33, Zhang Chen wrote:
>>>>>>> On Sat, Jan 12, 2019 at 12:15 AM Dr. David Alan Gilbert
>>>>>>> <dgilbert@redhat.com  <mailto:dgilbert@redhat.com>> wrote:
>>>>>>>
>>>>>>>        * Peter Maydell (peter.maydell@linaro.org
>>>>>>>        <mailto:peter.maydell@linaro.org>) wrote:
>>>>>>>        > Recently I've noticed that test-filter-mirror has been h=
anging
>>>>>>>        > intermittently, typically when run on some other TCG arc=
hitecture.
>>>>>>>        > In the instance I've just looked at, this was with s390x=
 guest on
>>>>>>>        > x86-64 host, though I've also seen it on other host arch=
s and
>>>>>>>        > perhaps with other guests.
>>>>>>>
>>>>>>>        Watch out to see if you really do see it for other guests;
>>>>>>>        it carefully avoids using virtio-net to avoid vhost; but o=
n s390x it
>>>>>>>        uses virtio-net-ccw - could that hit the vhost it was tryi=
ng to avoid?
>>>>>>>
>>>>>>>        > Below is a backtrace, though it seems to be pretty unhel=
pful.
>>>>>>>        > Anybody got any theories ? Does the mirror test rely on =
dirty
>>>>>>>        > memory bitmaps like the migration test (which also hangs
>>>>>>>        > occasionally with TCG due to some bug I'm sure we've inv=
estigated
>>>>>>>        > in the past) ?
>>>>>>>
>>>>>>>        I don't think it relies on the CPU at all.
>>>>>>>     I have no idea about this currently, but Jason and I designed=
 the
>>>>>>> test case.
>>>>>>> Add Jason: Have any comments about this ?
>>>>>> I can't reproduce this locally with s390x-softmmu. It looks to me =
the
>>>>>> test should be independent to any kinds of emulation. It should pa=
ss
>>>>>> when mainloop work.
>>>>> I've just seen a hang with ppc64 guest on s390x host, so it is
>>>>> indeed not specific to s390x guest (and so not specific to
>>>>> virtio-net either, since the ppc64 guest setup uses e1000).
>>>>>
>>>>> thanks
>>>>> -- PMM
>>>> Finally reproduced locally after hundreds (sometimes thousands) time=
s of
>>>> running.
>>>>
>>>> Bisection points to OOB monitor[1].
>>>>
>>>> It looks to me after OOB is used unconditionally we lose a barrier t=
o make
>>>> sure socket is connected before sending packets in test-filter-mirro=
r.c. Is
>>>> there any other similar and simple thing that we could do to kick th=
e
>>>> mainloop?
>>> Do you mean the:
>>>
>>>       /* send a qmp command to guarantee that 'connected' is setting =
to true. */
>>>       qmp_discard_response(qts, "{ 'execute' : 'query-status'}");
>>
>> Yes.
>>
>>
>>> why was that ever sufficient to know the socket was ready?
>>
>> It was suggested by Fam, I don't remember the details. Can we make
>> sure all pending events has been processed (UNIX socket was set to
>> connected) after query-status is returned with an non OOB monitor?
> I'm afraid I lack context.  Which socket are you talking about?  The
> test has at least the QMP socket, the send_sock[], and recv_sock.  What
> exactly are you trying to accomplish?


I mean recv_sock. If mirror tries to send a packet to it before its=20
is_connected is set to true, packet will be dropped.


>
> By the way, mkstemp(sock_path) followed by unix_connect(sock_path, NULL=
)
> looks rather fishy.  Why create a temporary file only to create a Unix
> domain socket right over it?


I vaguely remember passing fd created by unix domain socket doesn't work=20
when the test is introduced. So my understanding is the author needs a=20
way to create a unique file name which will be used b Unix domain socket=20
at that time.



>   Why is ignoring errors a good idea?


I don't get, which error is missed, it checks the return value of both=20
mkstemp() and unix_connect().

Thanks
