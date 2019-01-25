Received: from eggs.gnu.org ([209.51.188.92]:55940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gmvfo-00031b-1q
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 02:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gmvfm-000746-Vz
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 02:13:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gmvfm-00073Q-Mx
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 02:13:06 -0500
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
	<fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
	<CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
	<64411f3f-0071-fc94-945c-af16cf5edc77@redhat.com>
	<20190123195345.GI2193@work-vm> <20190124101155.GA7953@redhat.com>
	<20190124103023.GB7953@redhat.com> <20190124110146.GC7953@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1ee4b9df-bd9c-0af8-e4a4-dbce44485f50@redhat.com>
Date: Fri, 25 Jan 2019 15:12:51 +0800
MIME-Version: 1.0
In-Reply-To: <20190124110146.GC7953@redhat.com>
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


On 2019/1/24 =E4=B8=8B=E5=8D=887:01, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Jan 24, 2019 at 10:30:23AM +0000, Daniel P. Berrang=C3=A9 wrote=
:
>> On Thu, Jan 24, 2019 at 10:11:55AM +0000, Daniel P. Berrang=C3=A9 wrot=
e:
>>> On Wed, Jan 23, 2019 at 07:53:46PM +0000, Dr. David Alan Gilbert wrot=
e:
>>>> Do you mean the:
>>>>
>>>>      /* send a qmp command to guarantee that 'connected' is setting =
to true. */
>>>>      qmp_discard_response(qts, "{ 'execute' : 'query-status'}");
>>>>
>>>> why was that ever sufficient to know the socket was ready?
>>> This doesn't make any sense to me.
>>>
>>> There's the netdev socket, which has been passed in as a pre-opened s=
ocket
>>> FD, so that's guaranteed connected.
>>>
>>> There's the chardev server socket, to which we've just done a unix_co=
nnect()
>>> call to establish a connection. If unix_connect() has succeeded, then=
 at least
>>> the socket is connected & ready for I/O from the test's side. This is=
 a
>>> reliable stream socket, so even if the test sends data on the socket =
right away
>>> and QEMU isn't ready, it won't be lost. It'll be buffered and receive=
d by QEMU
>>> as soon as QEMU starts to monitor for incoming data on the socket.
>>>
>>> So I don't get what trying to wait for a "connected" state actually a=
chieves.
>>> It feels like a mistaken attempt to paper over some other unknown fla=
w that
>>> just worked by some lucky side-effect.
>> Immediately after writing that, I see what's happened.
>>
>> The  filter_redirector_receive_iov() method is triggered when QEMU rea=
ds
>> from the -netdev socket (which we passed in as an FD and immediately
>> write to).
>>
>> This method will discard all data, however, if the chr_out -chardev is
>> not in a connected state. So we do indeed have a race condition in thi=
s
>> test suite.
>>
>> In fact I'd say this filter-mirror object is racy by design even when
>> run in normal usage, if your chardev is a server mode with "nowait" se=
t,
>> or is a client mode with "reconnect" set. It will simply discard data.
>>
>> We can fix the test suite by using FD passing for the -chardev
>> too, so we're guaranteed to be connected immediately.  It might be
>> possible to remove "nowait" flag, but I'm not sure if that will cause
>> problems with the qtest handshake as it might block QEMU at startup
>> preventing qtest handshake from being performed.
>>
>> If we care about the race in real QEMU execution, then we must either
>> document that "nowait" or "reconnect" should never be used with
>> filter-mirror, or perhaps can make use of "qemu_chr_wait_connected"
>> to synchronize startup fo the filter-mirror object with the chardev
>> initialization. That could fix the test suite too
> Actually using qemu_chr_wait_connected would cause the test suite to
> hang, and it wouldn't fix data loss in the case where the chardev
> disconnected and then waited to connect again.
>
> I think the core problem here is that the netdev code assumes that the
> filters are always able to process packets. A proper solution would
> involve the filters having a "bool ready" state and callback to notify
> the netdev anytime this state changes.
>
> The filter-mirror should *not* report ready until the chardev has been
> opened.
>
> The netdevs should then not read packets off the wire unless all the
> regsitered filters are reporting that they are ready.


Netdev should know nothing about filters. And there will be still a race=20
between iterating all filters and handling disconnection if we did this.


>   If a filter then
> transitions to not-ready, the netdev should again stop reading packets
> off the wire & queue any that it might have had in flight, until the
> filter becomes ready again.


I agree to queue the packets in this case.

Thanks


>
> Without this kind of setup the filters are inherantly racy in several
> of the possible -chardev  configurations.
>
> In that sense the flaky test has actually done us a favour showing that
> the code is broken. It is not in fact the test that is broken, and thou=
gh
> we could workaround it in the test that doens't fix the root cause prob=
lem.
>
> Regards,
> Daniel
