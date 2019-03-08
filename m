Received: from eggs.gnu.org ([209.51.188.92]:52443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h2KMX-00008u-Q6
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h2KMW-0001tk-V4
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:36:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:21067)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1h2KMW-0001rx-Kj
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:36:52 -0500
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Fri, 8 Mar 2019 18:36:44 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D7806070A6F@shsmsx102.ccr.corp.intel.com>
References: <20190303145021.2962-1-chen.zhang@intel.com>
	<20190303145021.2962-7-chen.zhang@intel.com>
	<20190308174108.GG2834@work-vm>
In-Reply-To: <20190308174108.GG2834@work-vm>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH V3 6/7] Migration/colo.c: Add the necessary
 checks for colo_do_failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>



-----Original Message-----
From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]=20
Sent: Saturday, March 9, 2019 1:41 AM
To: Zhang, Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>; Zhang Chen <zhangckid@gmail.com>=
; Juan Quintela <quintela@redhat.com>; zhanghailiang <zhang.zhanghailiang@h=
uawei.com>; Markus Armbruster <armbru@redhat.com>; Eric Blake <eblake@redha=
t.com>; qemu-dev <qemu-devel@nongnu.org>
Subject: Re: [PATCH V3 6/7] Migration/colo.c: Add the necessary checks for =
colo_do_failover

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

OK, we should make that properly return an error.
(Actually we should make the failover command be one of the new OOB command=
s; so that it can work even if the main loop is blocked- that would make CO=
LO robust properly against network failures)

Good idea~ which OOB command can be the demo in current Qemu?
Maybe I can do this job in the future.

Thanks
Zhang Chen

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/colo.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c index=20
> dbe2b88807..d1ae2e6d11 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -197,10 +197,16 @@ void colo_do_failover(MigrationState *s)
>          vm_stop_force_state(RUN_STATE_COLO);
>      }
> =20
> -    if (get_colo_mode() =3D=3D COLO_MODE_PRIMARY) {
> +    switch (get_colo_mode()) {
> +    case COLO_MODE_PRIMARY:
>          primary_vm_do_failover();
> -    } else {
> +        break;
> +    case COLO_MODE_SECONDARY:
>          secondary_vm_do_failover();
> +        break;
> +    default:
> +        error_report("colo_do_failover failed because the colo mode"
> +                     " could not be obtained");
>      }
>  }
> =20
> --
> 2.17.GIT
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
