Received: from eggs.gnu.org ([2001:4830:134:3::10]:54041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUa6g-0004K3-QQ
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:33:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUa6c-0003be-RL
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:33:02 -0500
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-5-eblake@redhat.com>
	<25e2852c-7bf8-dadd-8c0d-32c2229ed187@virtuozzo.com>
	<211449a7-01ef-abcb-88c0-15d2eda67d6e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f52a3622-6f41-0c96-2dbb-62d6ce02e810@redhat.com>
Date: Wed, 5 Dec 2018 10:32:35 -0600
MIME-Version: 1.0
In-Reply-To: <211449a7-01ef-abcb-88c0-15d2eda67d6e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/14] qemu-nbd: Simplify --partition
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

On 12/5/18 10:26 AM, Eric Blake wrote:

>> is it possible, that "char *ep" remains uninitialized, and than we acc=
ess
>> it in check_strtox_error? I don's see in strtol spec a guarantee of=20
>> setting
>> endptr on failure path.
>=20
> C99 7.10.1.4 P5-7 requires strtoll() and friends to assign through=20
> 'endptr' if it is non-NULL, for both success and ERANGE failure cases.=20
> POSIX then further requires 'endptr' to be set for EINVAL failures due=20
> to out-of-range 'base' (not that we have any such callers), and permits=
=20
> (but does not require) the empty string to cause an EINVAL failure (but=
=20
> whether or not EINVAL happened, 'endptr' is still set).=C2=A0 There are=
 no=20
> other possible failures, so no, we are not dereferencing an=20
> uninitialized variable in check_strtox_error.

Correction, quoting POSIX:

http://pubs.opengroup.org/onlinepubs/9699919799/functions/strtol.html

APPLICATION USAGE

     Since the value of *endptr is unspecified if the value of base is=20
not supported, applications should either ensure that base has a=20
supported value (0 or between 2 and 36) before the call, or check for an=20
[EINVAL] error before examining *endptr.

So yes, we CAN end up transferring an uninitialized variable into the=20
caller's non-NULL endpointer if the caller passes an out-of-range base=20
(this particular caller passes NULL for an endpointer, and an in-range=20
base, so it's not an issue).  Might be worth a separate patch to assert=20
that base is in range for all of the qemu_strto* helpers, if we are=20
worried (I'm not).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
