Received: from eggs.gnu.org ([2001:4830:134:3::10]:34274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFGUo-0007qP-5K
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFGUj-0003vy-En
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:57:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dFGUj-0003tf-6x
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:57:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170513004616.25749-1-n54@gmx.com>
	<20170526054013.299-1-n54@gmx.com>
	<CAJ+F1CJBQuKFK=6m1_1BEoKJmyvUPU_U4ai1xExxVjFnXT1g1Q@mail.gmail.com>
Date: Mon, 29 May 2017 10:57:41 +0200
In-Reply-To: <CAJ+F1CJBQuKFK=6m1_1BEoKJmyvUPU_U4ai1xExxVjFnXT1g1Q@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 26 May 2017
	06:31:25 +0000")
Message-ID: <87k2509h16.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: ivshmem-clean: Install
 only when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, f4bug@amsat.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Fri, May 26, 2017 at 9:49 AM Kamil Rytarowski <n54@gmx.com> wrote:
>
>> Currently ivshmem requires eventfd() which is Linux specific.
>> Do not and build it unconditionally on every Linux/BSD/Solaris.
>>
>>
> I think it should be able to use pipe fallback from event_notifier_init()=
 .

Not easily.  ivshmem fundamentally needs event_notifier_init_fd(), which
is CONFIG_EVENTFD:

commit 330b58368ca16c31efdadcf8263f7f903546af50
Author: Markus Armbruster <armbru@redhat.com>
Date:   Tue Mar 15 19:34:20 2016 +0100

    event_notifier: Make event_notifier_init_fd() #ifdef CONFIG_EVENTFD
=20=20=20=20
    Event notifiers are designed for eventfd(2).  They can fall back to
    pipes, but according to Paolo, event_notifier_init_fd() really
    requires the real thing, and should therefore be under #ifdef
    CONFIG_EVENTFD.  Do that.
=20=20=20=20
    Its only user is ivshmem, which is currently CONFIG_POSIX.  Narrow it
    to CONFIG_EVENTFD.
=20=20=20=20
    Cc: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Markus Armbruster <armbru@redhat.com>
    Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
    Message-Id: <1458066895-20632-6-git-send-email-armbru@redhat.com>

>> This patch indirectly fixes build failure on NetBSD, where these tools
>> additionally require -lrl for shm_open(3). In future there should be

Do you mean -lrt?

>> added support for NetBSD and the linking addressed appropriately.
>>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>>
> ---
>>  configure | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/configure b/configure
>> index 1a5ee4b909..84d8660354 100755
>> --- a/configure
>> +++ b/configure
>> @@ -4928,6 +4928,8 @@ if test "$want_tools" =3D "yes" ; then
>>    tools=3D"qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
>>    if [ "$linux" =3D "yes" -o "$bsd" =3D "yes" -o "$solaris" =3D "yes" ]=
 ; then
>>      tools=3D"qemu-nbd\$(EXESUF) $tools"
>> +  fi
>> +  if [ "$eventfd" !=3D "no" ]; then

"$eventfd" =3D "yes" would be clearer, wouldn't it?

>>      tools=3D"ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
>>    fi
>>  fi

With the -l in the commit message double-checked:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

Do you think squashing in the appended diff would make sense?


diff --git a/contrib/ivshmem-client/Makefile.objs b/contrib/ivshmem-client/=
Makefile.objs
index bfab2d2..13d8640 100644
--- a/contrib/ivshmem-client/Makefile.objs
+++ b/contrib/ivshmem-client/Makefile.objs
@@ -1 +1 @@
-ivshmem-client-obj-y =3D ivshmem-client.o main.o
+ivshmem-client-obj-$(CONFIG_IVSHMEM) =3D ivshmem-client.o main.o
diff --git a/contrib/ivshmem-server/Makefile.objs b/contrib/ivshmem-server/=
Makefile.objs
index c060dd3..d9469fd 100644
--- a/contrib/ivshmem-server/Makefile.objs
+++ b/contrib/ivshmem-server/Makefile.objs
@@ -1 +1 @@
-ivshmem-server-obj-y =3D ivshmem-server.o main.o
+ivshmem-server-obj-$(CONFIG_IVSHMEM) =3D ivshmem-server.o main.o
