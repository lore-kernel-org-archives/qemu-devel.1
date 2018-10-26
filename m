Received: from eggs.gnu.org ([2001:4830:134:3::10]:60223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gG1sm-0000Bp-Eh
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gG1sh-0002mV-HW
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:10:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:41204 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gG1sg-0002ko-Sv
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:10:27 -0400
References: <20181022110854.10284-1-fli@suse.com>
	<20181024212742.GB30830@xz-x1.hotspot.internet-for-guests.com>
	<45194647-7b30-df97-5517-1c758947a91e@suse.com>
	<20181025113229.GC30830@xz-x1.hotspot.internet-for-guests.com>
From: Fei Li <fli@suse.com>
Message-ID: <f528529e-e0e8-0264-422c-36e1a3881c49@suse.com>
Date: Fri, 26 Oct 2018 21:10:19 +0800
MIME-Version: 1.0
In-Reply-To: <20181025113229.GC30830@xz-x1.hotspot.internet-for-guests.com>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com



On 10/25/2018 08:58 PM, Peter Xu wrote:
> On Thu, Oct 25, 2018 at 05:04:00PM +0800, Fei Li wrote:
>
> [...]
>
>> @@ -1325,22 +1325,24 @@ bool multifd_recv_all_channels_created(void)
>>  =C2=A0/* Return true if multifd is ready for the migration, otherwise=
 false */
>>  =C2=A0bool multifd_recv_new_channel(QIOChannel *ioc)
>>  =C2=A0{
>> +=C2=A0=C2=A0=C2=A0 MigrationIncomingState *mis =3D migration_incoming=
_get_current();
>>  =C2=A0=C2=A0=C2=A0=C2=A0 MultiFDRecvParams *p;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 int id;
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0 id =3D multifd_recv_initial_packet(ioc, &loc=
al_err);
>>  =C2=A0=C2=A0=C2=A0=C2=A0 if (id < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multifd_recv_terminate_thr=
eads(local_err);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_reportf_err(local_er=
r,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "failed to receive packet via multifd channel %x:
>> ",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 multifd_recv_state->count);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0 p =3D &multifd_recv_state->params[id];
>>  =C2=A0=C2=A0=C2=A0=C2=A0 if (p->c !=3D NULL) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&local_er=
r, "multifd: received id '%d' already setup'",
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multifd_recv_terminate_thr=
eads(local_err);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>>  =C2=A0=C2=A0=C2=A0=C2=A0 p->c =3D ioc;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 object_ref(OBJECT(ioc));
>> @@ -1352,6 +1354,11 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEM=
U_THREAD_JOINABLE);
>>  =C2=A0=C2=A0=C2=A0=C2=A0 atomic_inc(&multifd_recv_state->count);
>>  =C2=A0=C2=A0=C2=A0=C2=A0 return multifd_recv_state->count =3D=3D migr=
ate_multifd_channels();
>> +fail:
>> +=C2=A0=C2=A0=C2=A0 multifd_recv_terminate_threads(local_err);
>> +=C2=A0=C2=A0=C2=A0 qemu_fclose(mis->from_src_file);
>> +=C2=A0=C2=A0=C2=A0 mis->from_src_file =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>  =C2=A0}
> Yeah I think it makes sense to at least report some details when error
> happens, but I'm not sure whether it's good to explicitly exit() here.
> IMHO you can add an Error** in multifd_recv_new_channel() parameter
> list to do that, and even through migration_ioc_process_incoming().
> What do you think?
>
> Regards,
>
You mean exit() in migration_ioc_process_incoming(), or further
caller migration_channel_process_incoming()? Actually either is
ok for me. :) But today I find if using postcopy and multifd together
to do live migration, it seems the hang still occurs even with the
above codes, so sad about that. I will keep debugging and see
how to fix this.

Have a nice day, thanks
Fei
