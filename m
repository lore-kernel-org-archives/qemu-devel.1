Received: from eggs.gnu.org ([2001:4830:134:3::10]:56683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gZAjQ-00080p-VP
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gZAjL-000204-3k
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:28:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gZAjJ-0001yg-3K
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:27:54 -0500
References: <20181213184340.24037-1-armbru@redhat.com>
	<20181213184340.24037-33-armbru@redhat.com>
	<fde45953-c713-daf7-f3ce-47d63b050f7a@redhat.com>
	<87k1k8j71u.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dabc589c-0206-708c-0f70-b524f23500a9@redhat.com>
Date: Tue, 18 Dec 2018 09:27:41 +0100
MIME-Version: 1.0
In-Reply-To: <87k1k8j71u.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Regression test with --disable options (was: qapi: add
 conditions to REPLICATION type/commands on the schema)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 2018-12-17 20:18, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> On 2018-12-13 19:43, Markus Armbruster wrote:
>>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>
>>> Add #if defined(CONFIG_REPLICATION) in generated code, and adjust the
>>> code accordingly.
>>>
>>> Made conditional:
>>>
>>> * xen-set-replication, query-xen-replication-status,
>>>   xen-colo-do-checkpoint
>>>
>>>   Before the patch, we first register the commands unconditionally in
>>>   generated code (requires a stub), then conditionally unregister in
>>>   qmp_unregister_commands_hack().
>>>
>>>   Afterwards, we register only when CONFIG_REPLICATION.  The command
>>>   fails exactly the same, with CommandNotFound.
>>>
>>>   Improvement, because now query-qmp-schema is accurate, and we're on=
e
>>>   step closer to killing qmp_unregister_commands_hack().
>>>
>>> * enum BlockdevDriver value "replication" in command blockdev-add
>>>
>>> * BlockdevOptions variant @replication
>>>
>>> and related structures.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>> Message-Id: <20181213123724.4866-23-marcandre.lureau@redhat.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  migration/colo.c     | 16 ++++------------
>>>  monitor.c            |  5 -----
>>>  qapi/block-core.json | 13 +++++++++----
>>>  qapi/migration.json  | 12 ++++++++----
>>>  4 files changed, 21 insertions(+), 25 deletions(-)
>>
>> I think this might have broken compilation with --disable-replication:
>>
>>  https://gitlab.com/huth/qemu/-/jobs/135648240
>=20
> Reproduced.
>=20
>> Any ideas how to fix it?
>=20
> The problem is fairly obvious, repair less so.  Sorry this escaped
> review.

This is the second time in 2 months that compilation with
--disable-replication broke. So instead of relying on reviews here, I
think we should catch this with Patchew / some docker based compilation
test instead that configures the build process with everything disabled,
e.g.:

 ./configure --enable-werror --disable-rdma --disable-slirp \
   --disable-curl --disable-capstone --disable-live-block-migration \
   --disable-glusterfs --disable-replication --disable-coroutine-pool \
   --disable-smartcard --disable-guest-agent --disable-curses \
   --disable-libxml2 --disable-tpm --disable-qom-cast-debug \
   --disable-spice --disable-vhost-vsock  --disable-vhost-net \
   --disable-vhost-crypto --disable-vhost-user ...

(I'm still one of those docker agnostics ... so if someone wants to come
up with a patch, I'd be very glad ... otherwise it'll take some time
'til I figured it out how to add a docker based test for this...)

 Thanks,
  Thomas
