Received: from eggs.gnu.org ([209.51.188.92]:55022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gr2Rc-0002Et-86
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:15:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gr2RY-0005If-Db
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:15:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42456
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gr2RU-0005ES-Fq
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:15:22 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x15Esr48177812
	for <qemu-devel@nongnu.org>; Tue, 5 Feb 2019 10:15:18 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qfb1dx6qt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:15:16 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Tue, 5 Feb 2019 15:14:52 -0000
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-2-cohuck@redhat.com>
	<20190130195127.5ff3c849@oc2783563651>
	<20190131125220.285a4bc8.cohuck@redhat.com>
	<20190131133455.3097613f@oc2783563651>
	<20190204163102.33d744d8.cohuck@redhat.com>
	<20190205125229.56c6e252@oc2783563651>
	<20190205133540.573902d8.cohuck@redhat.com>
	<ad60e2d5-f222-da38-41fd-bcbd7c9965a0@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 5 Feb 2019 10:14:46 -0500
MIME-Version: 1.0
In-Reply-To: <ad60e2d5-f222-da38-41fd-bcbd7c9965a0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <56301fff-3643-516b-a475-0f39b6221c5f@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/6] vfio-ccw: make it safe to access
 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org



On 02/05/2019 09:48 AM, Eric Farman wrote:
>=20
>=20
> On 02/05/2019 07:35 AM, Cornelia Huck wrote:
>> On Tue, 5 Feb 2019 12:52:29 +0100
>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>>> On Mon, 4 Feb 2019 16:31:02 +0100
>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>
>>>> On Thu, 31 Jan 2019 13:34:55 +0100
>>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>>> On Thu, 31 Jan 2019 12:52:20 +0100
>>>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>>>> On Wed, 30 Jan 2019 19:51:27 +0100
>>>>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>>>>> On Wed, 30 Jan 2019 14:22:07 +0100
>>>>>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>>>>>> When we get a solicited interrupt, the start function may have
>>>>>>>> been cleared by a csch, but we still have a channel program
>>>>>>>> structure allocated. Make it safe to call the cp accessors in
>>>>>>>> any case, so we can call them unconditionally.
>>>>>>>
>>>>>>> I read this like it is supposed to be safe regardless of
>>>>>>> parallelism and threads. However I don't see any explicit
>>>>>>> synchronization done for cp->initialized.
>>>>>>>
>>>>>>> I've managed to figure out how is that supposed to be safe
>>>>>>> for the cp_free() (which is probably our main concern) in
>>>>>>> vfio_ccw_sch_io_todo(), but if fail when it comes to the one
>>>>>>> in vfio_ccw_mdev_notifier().
>>>>>>>
>>>>>>> Can you explain us how does the synchronization work?
>>>>>>
>>>>>> You read that wrong, I don't add synchronization, I just add a che=
ck.
>>>>>
>>>>> Now I'm confused. Does that mean we don't need synchronization for=20
>>>>> this?
>>>>
>>>> If we lack synchronization (that is not provided by the current stat=
e
>>>> machine handling, or the rework here), we should do a patch on top
>>>> (preferably on top of the whole series, so this does not get even mo=
re
>>>> tangled up.) This is really just about the extra check.
>>>
>>> I'm not a huge fan of keeping or introducing races -- it makes things
>>> difficult to reason about, but I do have some understanging your
>>> position.
>>
>> The only thing I want to avoid is knowingly making things worse than
>> before, and I don't think this patch does that.
>>
>>>
>>> This patch-series is AFAICT a big improvement over what we have. I wo=
uld
>>> like Farhan confirming that it makes these hick-ups when he used to h=
it
>>> BUSY with another ssch request disappear. If it does (I hope it does)
>>> it's definitely a good thing for anybody who wants to use vfio-ccw.
>>
>> Yep. There remains a lot to be done, but it's a first step.
>=20
> s/a first step/an excellent first step/=C2=A0 :)
>=20
> Can't speak for Farhan, but this makes things somewhat better for me.=20
> I'm still getting some periodic errors, but they happen infrequently=20
> enough now that debugging them is frustrating.=C2=A0 ;-)
>=20
>  =C2=A0- Eric
>=20

I ran the my workloads/tests with the patches and like Eric I notice the=20
errors I previously hit less frequently.


>>
>>>
>>> Yet I find it difficult to slap my r-b over racy code, or partial
>>> solutions. In the latter case, when I lack conceptual clarity, I find=
 it
>>> difficult to tell if we are heading into the right direction, or is w=
hat
>>> we build today going to turn against us tomorrow. Sorry for being a=20
>>> drag.
>>
>> As long as we don't introduce bad user space interfaces we have to dra=
g
>> around forever, I think anything is fair game if we think it's a good
>> idea at that moment. We can rewrite things if it turned out to be a ba=
d
>> idea (although I'm not arguing for doing random crap, of course :)
>>
>=20
