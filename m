Received: from eggs.gnu.org ([209.51.188.92]:59023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gmsam-0004JB-HQ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 22:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gmsal-0001di-Bd
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 22:55:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gmsak-0001Sw-SX
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 22:55:43 -0500
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
	<fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
	<CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
	<64411f3f-0071-fc94-945c-af16cf5edc77@redhat.com>
	<20190123195345.GI2193@work-vm>
	<a0c711c1-17d4-9fbe-b78c-4cd4a2419633@redhat.com>
	<20190124091113.GA2101@work-vm> <20190124095152.GM18231@xz-x1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7c445e35-13f7-b017-3bb7-e01874014ed6@redhat.com>
Date: Fri, 25 Jan 2019 11:55:12 +0800
MIME-Version: 1.0
In-Reply-To: <20190124095152.GM18231@xz-x1>
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
To: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


On 2019/1/24 =E4=B8=8B=E5=8D=885:51, Peter Xu wrote:
> On Thu, Jan 24, 2019 at 09:11:15AM +0000, Dr. David Alan Gilbert wrote:
>> * Jason Wang (jasowang@redhat.com) wrote:
>>> On 2019/1/24 =E4=B8=8A=E5=8D=883:53, Dr. David Alan Gilbert wrote:
>>>> * Jason Wang (jasowang@redhat.com) wrote:
>>>>> On 2019/1/22 =E4=B8=8A=E5=8D=882:56, Peter Maydell wrote:
>>>>>> On Thu, 17 Jan 2019 at 09:46, Jason Wang<jasowang@redhat.com>  wro=
te:
>>>>>>> On 2019/1/15 =E4=B8=8A=E5=8D=8812:33, Zhang Chen wrote:
>>>>>>>> On Sat, Jan 12, 2019 at 12:15 AM Dr. David Alan Gilbert
>>>>>>>> <dgilbert@redhat.com  <mailto:dgilbert@redhat.com>> wrote:
>>>>>>>>
>>>>>>>>        * Peter Maydell (peter.maydell@linaro.org
>>>>>>>>        <mailto:peter.maydell@linaro.org>) wrote:
>>>>>>>>        > Recently I've noticed that test-filter-mirror has been =
hanging
>>>>>>>>        > intermittently, typically when run on some other TCG ar=
chitecture.
>>>>>>>>        > In the instance I've just looked at, this was with s390=
x guest on
>>>>>>>>        > x86-64 host, though I've also seen it on other host arc=
hs and
>>>>>>>>        > perhaps with other guests.
>>>>>>>>
>>>>>>>>        Watch out to see if you really do see it for other guests=
;
>>>>>>>>        it carefully avoids using virtio-net to avoid vhost; but =
on s390x it
>>>>>>>>        uses virtio-net-ccw - could that hit the vhost it was try=
ing to avoid?
>>>>>>>>
>>>>>>>>        > Below is a backtrace, though it seems to be pretty unhe=
lpful.
>>>>>>>>        > Anybody got any theories ? Does the mirror test rely on=
 dirty
>>>>>>>>        > memory bitmaps like the migration test (which also hang=
s
>>>>>>>>        > occasionally with TCG due to some bug I'm sure we've in=
vestigated
>>>>>>>>        > in the past) ?
>>>>>>>>
>>>>>>>>        I don't think it relies on the CPU at all.
>>>>>>>>     I have no idea about this currently, but Jason and I designe=
d the
>>>>>>>> test case.
>>>>>>>> Add Jason: Have any comments about this ?
>>>>>>> I can't reproduce this locally with s390x-softmmu. It looks to me=
 the
>>>>>>> test should be independent to any kinds of emulation. It should p=
ass
>>>>>>> when mainloop work.
>>>>>> I've just seen a hang with ppc64 guest on s390x host, so it is
>>>>>> indeed not specific to s390x guest (and so not specific to
>>>>>> virtio-net either, since the ppc64 guest setup uses e1000).
>>>>>>
>>>>>> thanks
>>>>>> -- PMM
>>>>> Finally reproduced locally after hundreds (sometimes thousands) tim=
es of
>>>>> running.
>>>>>
>>>>> Bisection points to OOB monitor[1].
>>>>>
>>>>> It looks to me after OOB is used unconditionally we lose a barrier =
to make
>>>>> sure socket is connected before sending packets in test-filter-mirr=
or.c. Is
>>>>> there any other similar and simple thing that we could do to kick t=
he
>>>>> mainloop?
>>>> Do you mean the:
>>>>
>>>>       /* send a qmp command to guarantee that 'connected' is setting=
 to true. */
>>>>       qmp_discard_response(qts, "{ 'execute' : 'query-status'}");
>>>
>>> Yes.
>>>
>>>
>>>> why was that ever sufficient to know the socket was ready?
>>>
>>> It was suggested by Fam, I don't remember the details. Can we make su=
re all
>>> pending events has been processed (UNIX socket was set to connected) =
after
>>> query-status is returned with an non OOB monitor?
>> I'm not sure - it doesn't sound like a 'query-status' should ensure
>> anything else.
>> How about something like a 'query-chardev' - can that tell you what yo=
u
>> need and loop until it's ready?
> Yeah it sounds hacky to use "query status" to make sure a specific
> chardev is connected even before the OOB...


Probably, but anyway it works before OOB.


>
> I saw that currently the chardev requires "nowait":
>
>      qts =3D qtest_initf(
>          "-netdev socket,id=3Dqtest-bn0,fd=3D%d "
>          "-device %s,netdev=3Dqtest-bn0,id=3Dqtest-e0 "
>          "-chardev socket,id=3Dmirror0,path=3D%s,server,nowait "
>          "-object filter-mirror,id=3Dqtest-f0,netdev=3Dqtest-bn0,queue=3D=
tx,outdev=3Dmirror0 "
>          , send_sock[1], devstr, sock_path);
>
> Could it work without "nowait"?  Would that make sure QEMU will wait
> until connection established before going on?


Doesn't work for qtest which will wait for the qemu as well.

Thanks


>
> Regards,
>
