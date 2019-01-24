Received: from eggs.gnu.org ([209.51.188.92]:57954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmbbt-0003uI-UP
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:47:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmbbt-000072-05
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:47:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gmbbr-0007kx-0t
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:47:43 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
	<fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
	<CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
	<64411f3f-0071-fc94-945c-af16cf5edc77@redhat.com>
	<20190123195345.GI2193@work-vm>
	<a0c711c1-17d4-9fbe-b78c-4cd4a2419633@redhat.com>
Date: Thu, 24 Jan 2019 10:47:22 +0100
In-Reply-To: <a0c711c1-17d4-9fbe-b78c-4cd4a2419633@redhat.com> (Jason Wang's
	message of "Thu, 24 Jan 2019 12:01:53 +0800")
Message-ID: <877eeuidzp.fsf@dusky.pond.sub.org>
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Please cc: me on QMP issues.

Jason Wang <jasowang@redhat.com> writes:

> On 2019/1/24 =E4=B8=8A=E5=8D=883:53, Dr. David Alan Gilbert wrote:
>> * Jason Wang (jasowang@redhat.com) wrote:
>>> On 2019/1/22 =E4=B8=8A=E5=8D=882:56, Peter Maydell wrote:
>>>> On Thu, 17 Jan 2019 at 09:46, Jason Wang<jasowang@redhat.com>  wrote:
>>>>> On 2019/1/15 =E4=B8=8A=E5=8D=8812:33, Zhang Chen wrote:
>>>>>> On Sat, Jan 12, 2019 at 12:15 AM Dr. David Alan Gilbert
>>>>>> <dgilbert@redhat.com  <mailto:dgilbert@redhat.com>> wrote:
>>>>>>
>>>>>>       * Peter Maydell (peter.maydell@linaro.org
>>>>>>       <mailto:peter.maydell@linaro.org>) wrote:
>>>>>>       > Recently I've noticed that test-filter-mirror has been hangi=
ng
>>>>>>       > intermittently, typically when run on some other TCG archite=
cture.
>>>>>>       > In the instance I've just looked at, this was with s390x gue=
st on
>>>>>>       > x86-64 host, though I've also seen it on other host archs and
>>>>>>       > perhaps with other guests.
>>>>>>
>>>>>>       Watch out to see if you really do see it for other guests;
>>>>>>       it carefully avoids using virtio-net to avoid vhost; but on s3=
90x it
>>>>>>       uses virtio-net-ccw - could that hit the vhost it was trying t=
o avoid?
>>>>>>
>>>>>>       > Below is a backtrace, though it seems to be pretty unhelpful.
>>>>>>       > Anybody got any theories ? Does the mirror test rely on dirty
>>>>>>       > memory bitmaps like the migration test (which also hangs
>>>>>>       > occasionally with TCG due to some bug I'm sure we've investi=
gated
>>>>>>       > in the past) ?
>>>>>>
>>>>>>       I don't think it relies on the CPU at all.
>>>>>>    I have no idea about this currently, but Jason and I designed the
>>>>>> test case.
>>>>>> Add Jason: Have any comments about this ?
>>>>> I can't reproduce this locally with s390x-softmmu. It looks to me the
>>>>> test should be independent to any kinds of emulation. It should pass
>>>>> when mainloop work.
>>>> I've just seen a hang with ppc64 guest on s390x host, so it is
>>>> indeed not specific to s390x guest (and so not specific to
>>>> virtio-net either, since the ppc64 guest setup uses e1000).
>>>>
>>>> thanks
>>>> -- PMM
>>> Finally reproduced locally after hundreds (sometimes thousands) times of
>>> running.
>>>
>>> Bisection points to OOB monitor[1].
>>>
>>> It looks to me after OOB is used unconditionally we lose a barrier to m=
ake
>>> sure socket is connected before sending packets in test-filter-mirror.c=
. Is
>>> there any other similar and simple thing that we could do to kick the
>>> mainloop?
>> Do you mean the:
>>
>>      /* send a qmp command to guarantee that 'connected' is setting to t=
rue. */
>>      qmp_discard_response(qts, "{ 'execute' : 'query-status'}");
>
>
> Yes.
>
>
>>
>> why was that ever sufficient to know the socket was ready?
>
>
> It was suggested by Fam, I don't remember the details. Can we make
> sure all pending events has been processed (UNIX socket was set to
> connected) after query-status is returned with an non OOB monitor?

I'm afraid I lack context.  Which socket are you talking about?  The
test has at least the QMP socket, the send_sock[], and recv_sock.  What
exactly are you trying to accomplish?

By the way, mkstemp(sock_path) followed by unix_connect(sock_path, NULL)
looks rather fishy.  Why create a temporary file only to create a Unix
domain socket right over it?  Why is ignoring errors a good idea?
