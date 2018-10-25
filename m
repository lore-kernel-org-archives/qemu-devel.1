Received: from eggs.gnu.org ([2001:4830:134:3::10]:43015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gFbYv-0006hL-2V
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 05:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gFbYq-0008TS-1n
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 05:04:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:54984 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gFbYn-0008PJ-Vc
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 05:04:11 -0400
References: <20181022110854.10284-1-fli@suse.com>
	<20181024212742.GB30830@xz-x1.hotspot.internet-for-guests.com>
From: Fei Li <fli@suse.com>
Message-ID: <45194647-7b30-df97-5517-1c758947a91e@suse.com>
Date: Thu, 25 Oct 2018 17:04:00 +0800
MIME-Version: 1.0
In-Reply-To: <20181024212742.GB30830@xz-x1.hotspot.internet-for-guests.com>
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com



On 10/25/2018 05:27 AM, Peter Xu wrote:
> On Mon, Oct 22, 2018 at 07:08:52PM +0800, Fei Li wrote:
>> Hi,
>> these two patches are to fix live migration issues. The first is
>> about multifd, and the second is to fix some error handling.
>>
>> But I have a question about using multifd migration.
>> In our current code, when multifd is used during migration, if there
>> is an error before the destination receives all new channels (I mean
>> multifd_recv_new_channel(ioc)), the destination does not exit but
>> keeps waiting (Hang in recvmsg() in qio_channel_socket_readv) until
>> the source exits.
>>
>> My question is about the state of the destination host if fails during
>> this period. I did a test, after applying [1/2] patch, if
>> multifd_new_send_channel_async() fails, the destination host hangs for
>> a while then later pops up a window saying
>>      "'QEMU (...) [stopped]' is not responding.
>>      You may choose to wait a short while for it to continue or force
>>      the application to quit entirely."
>> But after closing the window by clicking, the qemu on the dest still
>> hangs there until I exclusively kill the qemu on the source.
>>
>> The source host keeps running as expected, but I guess the hang
>> phenonmenon in the dest is not right.
>> Would someone kindly give some suggestions on this? Thanks a lot.
> Note that it's during KVM forum so the response from anyone might be
> slow (it ends this week).
Thanks for the kindly reminder. :)
> I think the thing you described seems normal since we can't guarantee
> the network is always stable, normally I'll expect that the migration
> will fail but it won't matter much since after all it's a precopy so
> we lose nothing.  So I'm curious about when the error you mentioned
> happens (e.g., total channel number is N, you only got M channels
> connected, with M < N) could you just simply kill the destination?
> Then AFAIU the source can just continue to run, right?
Yes, for the M < N situation, IMO the destination can be simply killed by
adding exit(EXIT_FAILURE) when it failed to receive packet via some
channel. The code is as below which has been tested, and result is the
source continues to run and the destination exits.
I'd like to write a separate patch if the below code/idea is acceptable
to fix the hang issue.

@@ -1325,22 +1325,24 @@ bool multifd_recv_all_channels_created(void)
 =C2=A0/* Return true if multifd is ready for the migration, otherwise fa=
lse */
 =C2=A0bool multifd_recv_new_channel(QIOChannel *ioc)
 =C2=A0{
+=C2=A0=C2=A0=C2=A0 MigrationIncomingState *mis =3D migration_incoming_ge=
t_current();
 =C2=A0=C2=A0=C2=A0=C2=A0 MultiFDRecvParams *p;
 =C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
 =C2=A0=C2=A0=C2=A0=C2=A0 int id;

 =C2=A0=C2=A0=C2=A0=C2=A0 id =3D multifd_recv_initial_packet(ioc, &local_=
err);
 =C2=A0=C2=A0=C2=A0=C2=A0 if (id < 0) {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multifd_recv_terminate_thread=
s(local_err);
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_reportf_err(local_err,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "failed to receive packet via multifd channel=20
%x: ",
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 multifd_recv_state->count);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
 =C2=A0=C2=A0=C2=A0=C2=A0 }

 =C2=A0=C2=A0=C2=A0=C2=A0 p =3D &multifd_recv_state->params[id];
 =C2=A0=C2=A0=C2=A0=C2=A0 if (p->c !=3D NULL) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&local_err, =
"multifd: received id '%d' already setup'",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id);
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multifd_recv_terminate_thread=
s(local_err);
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
 =C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0=C2=A0 p->c =3D ioc;
 =C2=A0=C2=A0=C2=A0=C2=A0 object_ref(OBJECT(ioc));
@@ -1352,6 +1354,11 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU_T=
HREAD_JOINABLE);
 =C2=A0=C2=A0=C2=A0=C2=A0 atomic_inc(&multifd_recv_state->count);
 =C2=A0=C2=A0=C2=A0=C2=A0 return multifd_recv_state->count =3D=3D migrate=
_multifd_channels();
+fail:
+=C2=A0=C2=A0=C2=A0 multifd_recv_terminate_threads(local_err);
+=C2=A0=C2=A0=C2=A0 qemu_fclose(mis->from_src_file);
+=C2=A0=C2=A0=C2=A0 mis->from_src_file =3D NULL;
+=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
 =C2=A0}

Have a nice day, thanks a lot
Fei
>>
>> Fei Li (2):
>>    migration: fix the multifd code
>>    migration: fix some error handling
>>
>>   migration/migration.c    |  5 +----
>>   migration/postcopy-ram.c |  3 +++
>>   migration/ram.c          | 33 +++++++++++++++++++++++----------
>>   migration/ram.h          |  2 +-
>>   4 files changed, 28 insertions(+), 15 deletions(-)
>>
>> --=20
>> 2.13.7
>>
> Regards,
>
