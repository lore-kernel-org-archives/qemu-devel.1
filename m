Received: from eggs.gnu.org ([209.51.188.92]:53689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gmvTm-0007Lk-0H
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 02:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gmvTi-00016Z-1p
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 02:00:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gmvTg-00013x-3a
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 02:00:37 -0500
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
	<fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
	<CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
	<64411f3f-0071-fc94-945c-af16cf5edc77@redhat.com>
	<20190123195345.GI2193@work-vm> <20190124101155.GA7953@redhat.com>
	<20190124103023.GB7953@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8f721074-6e88-aedd-3c09-0648cdc9aeda@redhat.com>
Date: Fri, 25 Jan 2019 15:00:19 +0800
MIME-Version: 1.0
In-Reply-To: <20190124103023.GB7953@redhat.com>
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
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


On 2019/1/24 =E4=B8=8B=E5=8D=886:30, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Jan 24, 2019 at 10:11:55AM +0000, Daniel P. Berrang=C3=A9 wrote=
:
>> On Wed, Jan 23, 2019 at 07:53:46PM +0000, Dr. David Alan Gilbert wrote=
:
>>> * Jason Wang (jasowang@redhat.com) wrote:
>>>> On 2019/1/22 =E4=B8=8A=E5=8D=882:56, Peter Maydell wrote:
>>>>> On Thu, 17 Jan 2019 at 09:46, Jason Wang <jasowang@redhat.com> wrot=
e:
>>>>>> On 2019/1/15 =E4=B8=8A=E5=8D=8812:33, Zhang Chen wrote:
>>>>>>> On Sat, Jan 12, 2019 at 12:15 AM Dr. David Alan Gilbert
>>>>>>> <dgilbert@redhat.com <mailto:dgilbert@redhat.com>> wrote:
>>>>>>>
>>>>>>>       * Peter Maydell (peter.maydell@linaro.org
>>>>>>>       <mailto:peter.maydell@linaro.org>) wrote:
>>>>>>>       > Recently I've noticed that test-filter-mirror has been ha=
nging
>>>>>>>       > intermittently, typically when run on some other TCG arch=
itecture.
>>>>>>>       > In the instance I've just looked at, this was with s390x =
guest on
>>>>>>>       > x86-64 host, though I've also seen it on other host archs=
 and
>>>>>>>       > perhaps with other guests.
>>>>>>>
>>>>>>>       Watch out to see if you really do see it for other guests;
>>>>>>>       it carefully avoids using virtio-net to avoid vhost; but on=
 s390x it
>>>>>>>       uses virtio-net-ccw - could that hit the vhost it was tryin=
g to avoid?
>>>>>>>
>>>>>>>       > Below is a backtrace, though it seems to be pretty unhelp=
ful.
>>>>>>>       > Anybody got any theories ? Does the mirror test rely on d=
irty
>>>>>>>       > memory bitmaps like the migration test (which also hangs
>>>>>>>       > occasionally with TCG due to some bug I'm sure we've inve=
stigated
>>>>>>>       > in the past) ?
>>>>>>>
>>>>>>>       I don't think it relies on the CPU at all.
>>>>>>>    I have no idea about this currently, but Jason and I designed =
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
>>>>
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
>>>      /* send a qmp command to guarantee that 'connected' is setting t=
o true. */
>>>      qmp_discard_response(qts, "{ 'execute' : 'query-status'}");
>>>
>>> why was that ever sufficient to know the socket was ready?
>> This doesn't make any sense to me.
>>
>> There's the netdev socket, which has been passed in as a pre-opened so=
cket
>> FD, so that's guaranteed connected.
>>
>> There's the chardev server socket, to which we've just done a unix_con=
nect()
>> call to establish a connection. If unix_connect() has succeeded, then =
at least
>> the socket is connected & ready for I/O from the test's side. This is =
a
>> reliable stream socket, so even if the test sends data on the socket r=
ight away
>> and QEMU isn't ready, it won't be lost. It'll be buffered and received=
 by QEMU
>> as soon as QEMU starts to monitor for incoming data on the socket.
>>
>> So I don't get what trying to wait for a "connected" state actually ac=
hieves.
>> It feels like a mistaken attempt to paper over some other unknown flaw=
 that
>> just worked by some lucky side-effect.
> Immediately after writing that, I see what's happened.
>
> The  filter_redirector_receive_iov() method is triggered when QEMU read=
s
> from the -netdev socket (which we passed in as an FD and immediately
> write to).
>
> This method will discard all data, however, if the chr_out -chardev is
> not in a connected state. So we do indeed have a race condition in this
> test suite.
>
> In fact I'd say this filter-mirror object is racy by design even when
> run in normal usage, if your chardev is a server mode with "nowait" set=
,
> or is a client mode with "reconnect" set. It will simply discard data.


Is this issue only existed in the case of mirror? It looks to me some=20
other user of chardev has the same assumption. They neither wait for the=20
socket to be connected nor process the CHR_EVENT_OPEN.


>
> We can fix the test suite by using FD passing for the -chardev
> too, so we're guaranteed to be connected immediately.


Good to know this, I remember when the case is introduced this doesn't=20
work. Will post a fix shortly.


>    It might be
> possible to remove "nowait" flag, but I'm not sure if that will cause
> problems with the qtest handshake as it might block QEMU at startup
> preventing qtest handshake from being performed.


Yes, nowait doesn't work qtest wait for qemu in this case.


>
> If we care about the race in real QEMU execution, then we must either
> document that "nowait" or "reconnect" should never be used with
> filter-mirror, or perhaps can make use of "qemu_chr_wait_connected"
> to synchronize startup fo the filter-mirror object with the chardev
> initialization. That could fix the test suite too


 From my point of view, the issue is tcp_chr_write() drop packet=20
silently. If it can return error in this case, caller can decide e.g=20
queue the packets and resubmit when connection is established?

Thanks


>
> Regards,
> Daniel
