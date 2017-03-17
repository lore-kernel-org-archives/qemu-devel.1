Received: from eggs.gnu.org ([2001:4830:134:3::10]:40039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1copZp-0007TP-0x
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1copZl-0003zw-SW
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:57:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1copZl-0003zr-MS
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:57:41 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55A7B342C58
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 10:57:41 +0000 (UTC)
References: <20170316163640.5597-1-pbonzini@redhat.com>
	<20170317094102.GB11116@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab488c57-5006-e5db-145b-5b0cba1d3ead@redhat.com>
Date: Fri, 17 Mar 2017 11:57:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170317094102.GB11116@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-ga: obey LISTEN_PID when using
 systemd socket activation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>



On 17/03/2017 10:41, Stefan Hajnoczi wrote:
>> Luckily, qemu-nbd also got socket activation code, and its copy does
>> support LISTEN_PID.  Some extra fixups are needed to ensure that the
>> code can be used for both, but that's what this patch does.  The
>> main change is to replace get_listen_fds's "consume" argument with
>> the FIRST_SOCKET_ACTIVATION_FD macro from the qemu-nbd code.
>=20
> I intentionally wrote qga socket activation this way.  It allows socket
> activation to work together with daemonization.  That combination is
> probably not very useful so it's fine to get rid of it.

This works with my patch (and I've tested it now), because it looks up
LISTEN_FDS only once, way before daemonization.

The run_agent function grew a parameter that tells it to use
FIRST_SOCKET_ACTIVATION_FD as the file descriptor, without requiring
another look at the environment.  (And because daemonization forks but
doesn't exec, setting the cloexec flag doesn't get in the way either).

Thanks,

Paolo

> Please add an error message in qga/main.c if socket activation is used
> in combination with the -d/--daemonize flag.
