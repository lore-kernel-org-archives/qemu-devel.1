Received: from eggs.gnu.org ([2001:4830:134:3::10]:48664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpXNA-0007X3-CW
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpXN5-0001Pu-G8
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:20:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpXN5-0001PX-8P
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:20:19 -0400
References: <1534243693-9560-1-git-send-email-jianjay.zhou@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2278afdb-d2a6-54b3-67c7-c1f43e4d311c@redhat.com>
Date: Tue, 14 Aug 2018 13:20:16 +0200
MIME-Version: 1.0
In-Reply-To: <1534243693-9560-1-git-send-email-jianjay.zhou@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] vl: fix migration when watchdog expires
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, wangxinxin.wang@huawei.com

On 14/08/2018 12:48, Jay Zhou wrote:
> I got the following error when migrating a VM with watchdog
> device:
>=20
> {"timestamp": {"seconds": 1533884471, "microseconds": 668099},
> "event": "WATCHDOG", "data": {"action": "reset"}}
> {"timestamp": {"seconds": 1533884471, "microseconds": 677658},
> "event": "RESET", "data": {"guest": true}}
> {"timestamp": {"seconds": 1533884471, "microseconds": 677874},
> "event": "STOP"}
> qemu-system-x86_64: invalid runstate transition: 'prelaunch' -> 'postmi=
grate'
> Aborted
>=20
> The run state transition is RUN_STATE_FINISH_MIGRATE to RUN_STATE_PRELA=
UNCH,
> then the migration thread aborted when it tries to set RUN_STATE_POSTMI=
GRATE.
> There is a race between the main loop thread and the migration thread I=
 think.

In that case I think you shouldn't go to POSTMIGRATE at all, because the
VM has been reset.

Alternatively, when the watchdog fires in RUN_STATE_FINISH_MIGRATE
state, it might delay the action until after the "cont" command is
invoked on the source, but I'm not sure what's the best way to achieve
that...

Paolo
