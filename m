Received: from eggs.gnu.org ([2001:4830:134:3::10]:46465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gJtwD-0007tZ-Td
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:30:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gJtwA-00067j-Q5
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:30:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:44850 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gJtwA-00064y-JU
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 00:30:02 -0500
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-7-fli@suse.com> <20181102024611.GE7804@xz-x1>
From: Fei Li <fli@suse.com>
Message-ID: <14ac2b27-c796-a392-a229-c13bd207b91c@suse.com>
Date: Tue, 6 Nov 2018 13:29:52 +0800
MIME-Version: 1.0
In-Reply-To: <20181102024611.GE7804@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v7 6/9] migration: fix the multifd code
 when receiving less channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: quintela@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com



On 11/02/2018 10:46 AM, Peter Xu wrote:
> On Thu, Nov 01, 2018 at 06:17:12PM +0800, Fei Li wrote:
>
> [...]
>
>> @@ -1339,7 +1339,7 @@ bool multifd_recv_all_channels_created(void)
>>   }
>>  =20
>>   /* Return true if multifd is ready for the migration, otherwise fals=
e */
>> -bool multifd_recv_new_channel(QIOChannel *ioc)
>> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>>   {
>>       MultiFDRecvParams *p;
>>       Error *local_err =3D NULL;
>> @@ -1347,6 +1347,9 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>>  =20
>>       id =3D multifd_recv_initial_packet(ioc, &local_err);
>>       if (id < 0) {
>> +        error_propagate_prepend(errp, local_err,
>> +                        "failed to receive packet via multifd channel=
 %x: ",
> I'd use either %d or 0x%x, and some indent issue.
>
> Otherwise looks good to me.  Thanks,
>
Thanks, fixed as:
 =C2=A0=C2=A0=C2=A0=C2=A0 id =3D multifd_recv_initial_packet(ioc, &local_=
err);
 =C2=A0=C2=A0=C2=A0=C2=A0 if (id < 0) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate_prepend(errp,=
 local_err,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "failed to receive packet"
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " via multifd channel %d: ",
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multifd_recv_state->count);

Have a nice day :)
Fei
