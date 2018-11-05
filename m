Received: from eggs.gnu.org ([2001:4830:134:3::10]:34341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gJflc-0000Vk-Gl
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gJfla-0001P5-Jx
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:22:12 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20181009132330.7549-6-berrange@redhat.com> ("Daniel
	P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 9 Oct 2018 14:23:29
	+0100")
References: <20181009132330.7549-1-berrange@redhat.com>
	<20181009132330.7549-6-berrange@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 05 Nov 2018 15:21:48 +0100
Message-ID: <87efbzpptv.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/6] vnc: allow specifying a custom
 authorization object name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>, =?utf-8?Q?Marc-?= =?utf-8?Q?Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>
> The VNC server has historically had support for ACLs to check both the
> SASL username and the TLS x509 distinguished name. The VNC server was
> responsible for creating the initial ACL, and the client app was then
> responsible for populating it with rules using the HMP 'acl_add' command.
>
> This is not satisfactory for a variety of reasons. There is no way to
> populate the ACLs from the command line, users are forced to use the
> HMP. With multiple network services all supporting TLS and ACLs now, it
> is desirable to be able to define a single ACL that is referenced by all
> services.
>
> To address these limitations, two new options are added to the VNC
> server CLI. The 'tls-authz' option takes the ID of a QAuthZ object to
> use for checking TLS x509 distinguished names, and the 'sasl-authz'
> option takes the ID of another object to use for checking SASL usernames.
>
> In this example, we setup two authorization rules. The first allows any
> client with a certificate issued by the 'RedHat' organization in the
> 'London' locality. The second ACL allows clients with either the
> 'joe@REDHAT.COM' or  'fred@REDHAT.COM' kerberos usernames. Both checks
> must pass for the user to be allowed.
>
>     $QEMU -object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qemutls,\
>                   endpoint=3Dserver,verify-peer=3Dyes \
>           -object authz-simple,id=3Dauthz0,policy=3Ddeny,\
>                   rules.0.match=3DO=3DRedHat,,L=3DLondon,rules.0.policy=
=3Dallow \
>           -object authz-simple,id=3Dauthz1,policy=3Ddeny,\
>                   rules.0.match=3Dfred@REDHAT.COM,rules.0.policy=3Dallow \
>                   rules.0.match=3Djoe@REDHAT.COM,rules.0.policy=3Dallow \
>           -vnc 0.0.0.0:1,tls-creds=3Dtls0,tls-authz=3Dauthz0,
> 	       sasl,sasl-authz=3Dauthz1 \
>           ...other QEMU args...
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
