Received: from eggs.gnu.org ([2001:4830:134:3::10]:50834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gH1mP-0004Lx-QD
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 03:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gH1mK-0007QJ-OR
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 03:16:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:45632 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gH1mI-0007Pr-QM
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 03:15:59 -0400
References: <20181022110854.10284-1-fli@suse.com>
	<20181024212742.GB30830@xz-x1.hotspot.internet-for-guests.com>
	<45194647-7b30-df97-5517-1c758947a91e@suse.com>
	<20181025113229.GC30830@xz-x1.hotspot.internet-for-guests.com>
	<f528529e-e0e8-0264-422c-36e1a3881c49@suse.com>
	<20181026133546.GA5411@xz-x1> <20181026152458.GC2388@work-vm>
From: Fei Li <fli@suse.com>
Message-ID: <df58a52f-c81f-2a61-1a9f-2da0bc864159@suse.com>
Date: Mon, 29 Oct 2018 15:15:50 +0800
MIME-Version: 1.0
In-Reply-To: <20181026152458.GC2388@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 0/2] Fix migration issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com



On 10/26/2018 11:24 PM, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
>> On Fri, Oct 26, 2018 at 09:10:19PM +0800, Fei Li wrote:
>>>
>>> On 10/25/2018 08:58 PM, Peter Xu wrote:
>>>> On Thu, Oct 25, 2018 at 05:04:00PM +0800, Fei Li wrote:
>>>>
>>>> [...]
>>>>
>>>>> @@ -1325,22 +1325,24 @@ bool multifd_recv_all_channels_created(void=
)
>>>>>   =C2=A0/* Return true if multifd is ready for the migration, other=
wise false */
>>>>>   =C2=A0bool multifd_recv_new_channel(QIOChannel *ioc)
>>>>>   =C2=A0{
>>>>> +=C2=A0=C2=A0=C2=A0 MigrationIncomingState *mis =3D migration_incom=
ing_get_current();
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 MultiFDRecvParams *p;
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 int id;
>>>>>
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 id =3D multifd_recv_initial_packet(ioc, =
&local_err);
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 if (id < 0) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multifd_recv_terminate_=
threads(local_err);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_reportf_err(local=
_err,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "failed to receive packet via multifd channel %x:
>>>>> ",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 multifd_recv_state->count);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 p =3D &multifd_recv_state->params[id];
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 if (p->c !=3D NULL) {
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&loca=
l_err, "multifd: received id '%d' already setup'",
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multifd_recv_terminate_=
threads(local_err);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 p->c =3D ioc;
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 object_ref(OBJECT(ioc));
>>>>> @@ -1352,6 +1354,11 @@ bool multifd_recv_new_channel(QIOChannel *io=
c)
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
QEMU_THREAD_JOINABLE);
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 atomic_inc(&multifd_recv_state->count);
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 return multifd_recv_state->count =3D=3D =
migrate_multifd_channels();
>>>>> +fail:
>>>>> +=C2=A0=C2=A0=C2=A0 multifd_recv_terminate_threads(local_err);
>>>>> +=C2=A0=C2=A0=C2=A0 qemu_fclose(mis->from_src_file);
>>>>> +=C2=A0=C2=A0=C2=A0 mis->from_src_file =3D NULL;
>>>>> +=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>>>>   =C2=A0}
>>>> Yeah I think it makes sense to at least report some details when err=
or
>>>> happens, but I'm not sure whether it's good to explicitly exit() her=
e.
>>>> IMHO you can add an Error** in multifd_recv_new_channel() parameter
>>>> list to do that, and even through migration_ioc_process_incoming().
>>>> What do you think?
>>>>
>>>> Regards,
>>>>
>>> You mean exit() in migration_ioc_process_incoming(), or further
>>> caller migration_channel_process_incoming()? Actually either is
>>> ok for me. :) But today I find if using postcopy and multifd together
>>> to do live migration, it seems the hang still occurs even with the
>>> above codes, so sad about that. I will keep debugging and see
>>> how to fix this.
>> Maybe you can move the error_report_err() in
>> migration_channel_process_incoming() out of the TLS path so we can
>> report the error if either TLS or non-TLS case got something wrong.
Thanks for the advice. I will do the update in the next version. :)
>>
>> And I don't even know whether multifd could work with postcopy...
> Nope, it's not expected to work yet.
>
> Dave
Thanks for the helpful information. :)

BTW, in the next version, I'd like to merge these three migration=20
patches into
the "[PATCH RFC v6 ] qemu_thread_create: propagate the error to callers=20
to handle",
and cc you inside the patches. Please help to review.

Have a nice day, thanks again
Fei
>
>> Regards,
>>
>> --=20
>> Peter Xu
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
