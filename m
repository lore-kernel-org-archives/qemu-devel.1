Received: from eggs.gnu.org ([2001:4830:134:3::10]:33729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT9Ap-0001Lo-Lq
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT9Al-0006LW-VR
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:03:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40332 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fT9Al-0006Jw-KV
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:03:03 -0400
Date: Wed, 13 Jun 2018 18:02:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180613170259.GL19901@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1528212489-19137-1-git-send-email-lidongchen@tencent.com>
	<1528212489-19137-4-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1528212489-19137-4-git-send-email-lidongchen@tencent.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 03/10] migration: avoid concurrent
 invoke channel_close by different threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com, aviadye@mellanox.com, pbonzini@redhat.com, qemu-devel@nongnu.org, adido@mellanox.com, galsha@mellanox.com, Lidong Chen <lidongchen@tencent.com>

On Tue, Jun 05, 2018 at 11:28:02PM +0800, Lidong Chen wrote:
> The channel_close maybe invoked by different threads. For example, sour=
ce
> qemu invokes qemu_fclose in main thread, migration thread and return pa=
th
> thread. Destination qemu invokes qemu_fclose in main thread, listen thr=
ead
> and COLO incoming thread.

The only alternative approach would be to try to get all close calls
happening in the same thread, by having the other threads just set
some flag the primary thread watches.  This likely quite alot of
work to achieve though, so I agree just doing mutex locking is a
prudent solution.

>=20
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>  migration/migration.c | 2 ++
>  migration/migration.h | 7 +++++++
>  migration/qemu-file.c | 6 ++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
