Received: from eggs.gnu.org ([2001:4830:134:3::10]:53041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fW1YA-0000Wo-5y
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fW1Y6-0004lo-Ta
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:31:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59202 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fW1Y6-0004lM-OE
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:31:02 -0400
References: <20180615154203.11347-1-berrange@redhat.com>
	<20180615154203.11347-10-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c32feaa0-3a5b-3781-0f9e-21274f87b58b@redhat.com>
Date: Thu, 21 Jun 2018 10:30:59 -0500
MIME-Version: 1.0
In-Reply-To: <20180615154203.11347-10-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/11] authz: add QAuthZListFile object
 type for a file access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 06/15/2018 10:42 AM, Daniel P. Berrang=C3=A9 wrote:
> Add a QAuthZListFile object type that implements the QAuthZ interface. =
This
> built-in implementation is a proxy around the QAtuhZList object type,
> initializing it from an external file, and optionally, automatically
> reloading it whenever it changes.
>=20
> To create an instance of this object via the QMP monitor, the syntax
> used would be:
>=20
>        {
>          "execute": "object-add",
>          "arguments": {
>            "qom-type": "authz-list",
>            "id": "auth0",
>            "parameters": {
>              "filename": "/etc/qemu/vnc.acl",
> 	    "refresh": "yes"

Would this be better as a JSON bool instead of a "yes"/"no" string?

TAB damage.

>            }
>          }
>        }
>=20
> If "refresh" is "yes", inotify is used to monitor the file,
> automatically reloading changes. If an error occurs during reloading,
> all authorizations will fail until the file is next successfully
> loaded.
>=20
> The /etc/qemu/vnc.acl file would contain a JSON representation of a
> QAuthZList object
>=20
>      {
>        "rules": [
>           { "match": "fred", "policy": "allow", "format": "exact" },
>           { "match": "bob", "policy": "allow", "format": "exact" },
>           { "match": "danb", "policy": "deny", "format": "glob" },
>           { "match": "dan*", "policy": "allow", "format": "exact" },
>        ],
>        "policy": "deny"
>      }
>=20
> This sets up an authorization rule that allows 'fred', 'bob' and anyone
> whose name starts with 'dan', except for 'danb'. Everyone unmatched is
> denied.
>=20
> The object can be loaded on the comand line using

s/comand/command/

>=20
>     -object authz-list-file,id=3Dauthz0,filename=3D/etc/qemu/vnc.acl,re=
fresh=3Dyes

Double dash, for the sake of qemu-img

>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

> +/**
> + * QAuthZListFile:
> + *
> + * This authorization driver provides a file mechanism
> + * for granting access by matching user names against a
> + * file of globs. Each match rule has an associated policy
> + * and a catch all policy applies if no rule matches
> + *
> + * To create an instance of this class via QMP:
> + *
> + *  {
> + *    "execute": "object-add",
> + *    "arguments": {
> + *      "qom-type": "authz-list-file",
> + *      "id": "authz0",
> + *      "parameters": {
> + *        "filename": "/etc/qemu/myvm-vnc.acl",
> + *        "refresh": "yes"
> + *      }

If you change the commit message to use bool, also change this comment=20
to match.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
