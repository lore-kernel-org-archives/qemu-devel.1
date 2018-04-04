Received: from eggs.gnu.org ([2001:4830:134:3::10]:40087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3f5S-0004uX-6E
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3f5O-0004wy-1K
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:52:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f3f5N-0004wh-SP
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:52:09 -0400
References: <20180328173238.507470-1-vsementsov@virtuozzo.com>
	<20180328173238.507470-2-vsementsov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <749bccbe-614a-143b-6520-d6e3f82b9da6@redhat.com>
Date: Wed, 4 Apr 2018 11:52:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180328173238.507470-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] scripts/qemugdb: get pthread_self from
 "info threads" command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, den@openvz.org

On 28/03/2018 19:32, Vladimir Sementsov-Ogievskiy wrote:
> When debugging a coredump, pthread_self can't be obtained from
> function arch_prctl. Moreover if qemu crashed in coroutine, we
> can't find 'start_thread' in current stack-trace. So, add a method,
> actually proposed in 1138f24645e9e, which should work for gdb
> version >=3D 7.3.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

New-enough gdb can also use gdb.selected_thread()
> ---
>  scripts/qemugdb/coroutine.py | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.p=
y
> index ab699794ab..ffaa45c464 100644
> --- a/scripts/qemugdb/coroutine.py
> +++ b/scripts/qemugdb/coroutine.py
> @@ -14,6 +14,7 @@
>  # GNU GPL, version 2 or (at your option) any later version.
> =20
>  import gdb
> +import re
> =20
>  VOID_PTR =3D gdb.lookup_type('void').pointer()
> =20
> @@ -28,7 +29,17 @@ def get_fs_base():
>      return fs_base
> =20
>  def pthread_self():
> -    '''Fetch pthread_self() from the glibc start_thread function.'''
> +    # Try read pthread_self from gdb command 'info threads'.
> +    # Will fail for old gdb.
> +    try:
> +        threads =3D gdb.execute('info threads', False, True)
> +        m =3D re.search('^\* 1    Thread (0x[0-9a-f]+)', threads, re.M=
ULTILINE)

I don't think hard-coding "1" works here, and the spacing of the table
might differ as well.  However, looking for the asterisk seems safe from
a quick look at gdb source, and "Thread" looks like it isn't localized.

Paolo

> +        return int(m.group(1), 16)
> +    except TypeError:
> +        # gdb doesn't support third parameter for execute
> +        pass
> +
> +    # Try fetch pthread_self() from the glibc start_thread function.
>      f =3D gdb.newest_frame()
>      while f.name() !=3D 'start_thread':
>          f =3D f.older()
>=20
