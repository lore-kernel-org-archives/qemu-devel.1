Received: from eggs.gnu.org ([209.51.188.92]:48836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzQPE-0008Bg-2e
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzQPD-0007JJ-AW
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:27:40 -0500
References: <20190227162035.18543-1-berrange@redhat.com>
	<20190227162035.18543-2-berrange@redhat.com>
	<e6944ece-e00e-643a-fa71-deb18841e2fb@redhat.com>
	<20190228181812.GJ9217@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2c4ee767-de99-2fb4-fa3d-5f00a5b978fe@redhat.com>
Date: Thu, 28 Feb 2019 12:27:10 -0600
MIME-Version: 1.0
In-Reply-To: <20190228181812.GJ9217@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 1/3] qemu-nbd: add support for
 authorization of TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Juan Quintela <quintela@redhat.com>

On 2/28/19 12:18 PM, Daniel P. Berrang=C3=A9 wrote:

>> It doesn't hold up this patch, but I note that with the qemu QMP comma=
nd
>> changes you make in 2/3, you document that the object can be
>> created/removed on the fly, and the server will adjust which clients c=
an
>> then subsequently connect. Is there any need for the same sort of
>> runtime configurability in qemu-nbd, and if so, how would we accomplis=
h
>> it?  Perhaps by having a command-line option to parse --tls-authz from=
 a
>> file, where you can send SIGHUP to qemu-nbd to force it to re-read the
>> file?  Or am I worrying about something unlikely to be needed in pract=
ice?
>=20
> Well the QAuthZListFile object type can store its contents in an extern=
al
> file that gets auto-reloaded upon inotify triggers from the main loop.
> The QAuthZPAM type can also be fairly dynamic depending on its backend.
> I think any single process is unlikely  to need to switch between
> different object types, so this is good enough dynamic support.

That, and QMP nbd-server-start can serve up multiple exports, while
qemu-nbd serves exactly one export.

I also note that my work on incremental backups has raised the topic
that we someday want to support multiple parallel NBD servers.  Right
now, you are limited to exactly one (even though it can server multiple
exports), which makes serving different content to different clients
harder than if you could have different servers on separate ports with
per-server settings on which clients to allow.  Or, if we have tls-authz
items per-export instead of per-server, so that different clients see a
different subset of available exports when doing NBD_OPT_LIST.

>=20
> I can't help thinking we should add QMP to qemu-nbd one day though....

Yeah, as QMP nbd server gets more powerful, we may eventually need a
similar monitor interface into controlling a long-running qemu-nbd
process...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
