Received: from eggs.gnu.org ([2001:4830:134:3::10]:53128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f1Stx-0007kI-7I
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 04:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f1Sts-00072F-92
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 04:27:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f1Sts-00071M-2t
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 04:27:12 -0400
References: <20180328163630.48576-1-dgilbert@redhat.com>
	<20180328163630.48576-6-dgilbert@redhat.com>
	<780d6d45-84a6-34db-e65f-3d38a6d0ea66@redhat.com>
	<20180329080846.GA2982@work-vm>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <50fe8034-d0c1-94ea-40fc-b97b10ff5d8f@redhat.com>
Date: Thu, 29 Mar 2018 16:26:53 +0800
MIME-Version: 1.0
In-Reply-To: <20180329080846.GA2982@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/6] e1000: Choose which set of props to
 migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, eswierk@skyportsystems.com, qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com



On 2018=E5=B9=B403=E6=9C=8829=E6=97=A5 16:08, Dr. David Alan Gilbert wrot=
e:
> * Jason Wang (jasowang@redhat.com) wrote:
>>
>> On 2018=E5=B9=B403=E6=9C=8829=E6=97=A5 00:36, Dr. David Alan Gilbert (=
git) wrote:
>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>
>>> When we're using the subsection we migrate both
>>> the 'props' and 'tso_props' data; when we're not using
>>> the subsection (to migrate to 2.11 or old machine types) we've
>>> got to choose what to migrate in the main structure.
>>>
>>> If we're using the subsection migrate 'props' in the main structure.
>>> If we're not using the subsection then migrate the last one
>>> that changed, which gives behaviour similar to the old behaviour.
>>>
>>>
>> But only after migration. Why not simply switch back to the old behavi=
or if
>> migrate_tso_props if false?
> Because:
>    1) We know it's a broken behaviour so it's better not to unfix it
>    2) The fix doesn't change guest visible behaviour other than actuall=
y
>       sending the right packets; so there's no reason to make the fix
>       itself dependent on the machine type.
>    3) Gating the fix itself on the flag is actually more complex and
>       would need checking the flag in lots of places that are already
>       pretty complex, rather than what this does which is just check it
>       in one place at migration.

It looks to me it was just something like:

 =C2=A0=C2=A0=C2=A0 struct e1000x_txd_props *props =3D tp->cptse && chkfl=
ag(TSO) ?=20
&tp->tso_props : &tp->props;

Btw, did this patch work when:

migrate A to B
migrate B to C

But there's no tx during B?

Thanks

>
> Dave
>> Thanks
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
