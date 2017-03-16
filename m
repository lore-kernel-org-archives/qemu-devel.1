Received: from eggs.gnu.org ([2001:4830:134:3::10]:43062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coYMJ-00087E-Ps
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coYMG-0004a9-J6
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:34:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1coYMG-0004a1-Ck
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:34:36 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C914437F4C
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 16:34:36 +0000 (UTC)
References: <20170316161535.22157-1-pbonzini@redhat.com>
	<20170316161946.GA15193@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <82215544-b63e-65f8-dfe5-337b6ceef253@redhat.com>
Date: Thu, 16 Mar 2017 17:34:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170316161946.GA15193@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: obey LISTEN_PID when using
 systemd socket activation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 16/03/2017 17:19, Daniel P. Berrange wrote:
> On Thu, Mar 16, 2017 at 05:15:35PM +0100, Paolo Bonzini wrote:
>> qemu-ga's socket activation support was not obeying the LISTEN_PID
>> environment variable, which avoids that a process uses a socket-activa=
tion
>> file descriptor meant for its parent.
>>
>> Mess can for example ensue if a process forks a children before consum=
ing
>> the socket-activation file descriptor and therefore setting O_CLOEXEC
>> on it.
>>
>> Luckily, qemu-nbd also got socket activation code, and its copy does
>> support LISTEN_PID.  Some extra fixups are needed to ensure that the
>> code can be used for both, but that's what this patch does.  The
>> main change is to replace get_listen_fds's "consume" argument with
>> the FIRST_SOCKET_ACTIVATION_FD macro from the qemu-nbd code.
>>
>> Cc: "Richard W.M. Jones" <rjones@redhat.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  include/qemu/systemd.h |  26 +++++++++++++
>>  qemu-nbd.c             | 100 ++++------------------------------------=
---------
>>  qga/main.c             |  51 +++++++------------------
>>  util/Makefile.objs     |   1 +
>>  util/systemd.c         |  77 +++++++++++++++++++++++++++++++++++++
>=20
> A MAINTAINERS file entry for these new files ?

No idea of who would be a candidate.

Thanks for the fast review!

Paolo

>>  5 files changed, 125 insertions(+), 130 deletions(-)
>>  create mode 100644 include/qemu/systemd.h
>>  create mode 100644 util/systemd.c
>=20
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>=20
>=20
> Regards,
> Daniel
>=20
