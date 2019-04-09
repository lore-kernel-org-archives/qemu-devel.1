Received: from eggs.gnu.org ([209.51.188.92]:41621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjsq-0006tG-Na
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjsp-0000XK-CO
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:05:24 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-3-armbru@redhat.com>
	<20190408172202.GH3926@redhat.com>
	<d40c9fd6-6ae2-95f3-2f63-151ee1f13d0f@redhat.com>
Date: Tue, 09 Apr 2019 08:05:15 +0200
In-Reply-To: <d40c9fd6-6ae2-95f3-2f63-151ee1f13d0f@redhat.com> (Max Reitz's
	message of "Mon, 8 Apr 2019 20:33:22 +0200")
Message-ID: <877ec3iuhw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Whither qemu's ssh driver?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, ptoscano@redhat.com

Max Reitz <mreitz@redhat.com> writes:

> On 08.04.19 19:22, Richard W.M. Jones wrote:
>> I don't know much about this patch which looks like internal qemu
>> rearrangements so I guess fine.  However I do have a few things to say
>> about the ssh driver ...
>>=20
>> As you know I wrote this a few years ago, and it uses libssh2.
>> libssh2 has not evolved as quickly as we'd like and it may be better
>> to use libssh instead -- despite the names, these are two separate and
>> unrelated libraries.  libssh supports a wider range of SSH encryption
>> and has more features.  It's generally more likely to work against a
>> random SSH server.  It has also been through the FIPS process.  Indeed
>> Red Hat made the decision to switch exclusively to libssh in RHEL 8,
>> if that carries any weight.
>>=20
>> Pino posted a libssh2 -> libssh conversion patch a while back, but it
>> has been somewhat stuck in review.  If I recall the latest concern was
>> whether it performs as well as the libssh2 version.
>>=20
>>   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg07267.html
>>=20
>> In the meantime I added libssh support to nbdkit.  nbdkit can be used
>> as a complete replacement for qemu's ssh driver.
>>=20
>>   nbdkit ssh host=3Dfoo.example.com disk.img -U tmpdirXXXXXX/sock
>>   qemu -hda nbd:unix:tmpdirXXXXXX/sock
>>=20
>> In fact it's somewhat superior (IMHO) because all of the tricky code
>> handling libssh runs outside qemu in a separate process, improving
>> isolation and potentially allowing separate, restrictive security
>> policies to be applied.  For example it would no longer be necessary
>> to give qemu permission to connect to remote SSH servers.
>>=20
>> Could we make this really smooth somehow?  nbdkit has a concept
>> [https://www.mankier.com/1/nbdkit-captive] where we make it easy to
>> manage external commands owned by nbdkit.  Is there an equivalent
>> feature of qemu where:
>>=20
>>   qemu -object exec,id=3Dnbd1,cmd=3D'nbdkit -f -U $sock ssh ...' \
>>        -drive file.driver=3Dnbd,file.socket=3Dnbd1
>>=20
>> would run the command but also allocate a socket and kill the
>> subcommand on exit (of qemu)?
>>=20
>> Basically I'm trying to think about how to make this a reality:
>>=20
>>   https://rwmj.files.wordpress.com/2018/10/drawing2-svg.png
>>=20
>> Rich.
>
> I don=E2=80=99t disagree with anything you say.  I would prefer to move t=
he less
> well maintained drivers (for which there is no strict performance
> requirement) into a separate process.  nbdkit is perfectly suited for
> that, and the drivers are there, as you say (ssh, curl, vvfat).
>
> Having a nicer interface in qemu would make the transition simple,
> because we could tell users exactly how to change their command line so
> their use case continues to work.  I=E2=80=99m not sure whether it really=
 works,
> though, because I don=E2=80=99t think there is such a simple replacement =
for
> being able to simply pass "ssh://host/path" to qemu and have it work.
>
> But I think it=E2=80=99s still worth it.

I guess that boils down to "patches welcome".

For v1, I wouldn't worry about making the transition simple.  Just show
us some working code.
