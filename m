Received: from eggs.gnu.org ([2001:4830:134:3::10]:43243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXOjv-0004Rg-ID
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXOjq-0003zk-L1
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:28:55 -0400
References: <1528866321-23886-5-git-send-email-thuth@redhat.com>
	<20180613133840.GK24528@stefanha-x1.localdomain>
	<20180613134452.GU19901@redhat.com>
	<b0ebd968-797f-48e0-32c1-869c452feca9@redhat.com>
	<20180613151942.GC19901@redhat.com> <87k1r24quk.fsf@dusky.pond.sub.org>
	<20180619171539.0adc90d6.cohuck@redhat.com>
	<d4e02083-c372-3ce5-d4a2-4809579fc8f2@redhat.com>
	<20180622181108.GY7451@localhost.localdomain>
	<c10c2ffa-7ee2-5106-07d1-528df939d6ad@redhat.com>
	<20180622193522.GI7451@localhost.localdomain>
	<743d495e-51cd-8c8e-293e-026b8dece74a@redhat.com>
	<87lgb3xsv8.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4292432f-5f26-6925-4c14-ad1370e36e5b@redhat.com>
Date: Mon, 25 Jun 2018 12:28:34 +0200
MIME-Version: 1.0
In-Reply-To: <87lgb3xsv8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] qemu-options: Do not show
 -enable-kvm and -enable-hax in the docs anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, zhang.zhanghailiang@huawei.com, Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 25/06/2018 08:50, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 22/06/2018 21:35, Eduardo Habkost wrote:
>>>>> Why is this better than using KVM by default if it's available?
>>>> The answer is (as almost always): Compatibility with migration. Nobo=
dy
>>>> dares to sacrifice that chicken :-(
>>> We can now kill it if we announce the feature as deprecated a
>>> couple of releases in advance.
>>>
>>> If we declare that compatibility when the accelerator is omitted
>>> is deprecated in 3.0, in QEMU 3.3 we will be free to choose a
>>> different default accelerator.
>>
>> We can, we don't necessarily want it.
>>
>> The status quo is that people using KVM are invoking qemu as qemu-kvm,
>> people using TCG are invoking qemu as qemu-system-*.  All distros are
>> shipping a qemu-kvm or more rarely kvm binary, which is invariably a
>> wrapper script except for RHEL because RHEL doesn't have a qemu-system=
-*
>> binary at all.
>>
>> By the way, changing qemu-system-*'s default to e.g. RHEL's "kvm or tc=
g"
>> would not help distros that have "-accel kvm" in their /usr/bin/qemu-k=
vm
>> script.
>=20
> It wouldn't hurt them, either.

Right; to sum up, it does make things a little less consistent for their
users in two ways:

- qemu-system-<native> behaves differently from qemu-system-<others>.
For example, for ARM the default CPU model might not work for KVM, so
you would have to add a "-cpu xxx" option.

- qemu-system-<native> would still need an accelerator option on OS X or
Windows, where there is not quite parity between TCG and the native
accelerator, in terms of either features or stability.  Because of this
we wouldn't be able to change the default to "whatever virtualizing
accelerators are available followed by TCG".

> Attentive distros could even replace the wrapper script by a link.

If they are okay with replacing the "KVM only" semantics with "KVM or
TCG", which I think is generally worse.

Paolo

>> All in all, it seems simpler for me to take the status quo, which is
>> what non-RHEL distros do, and make it part of upstream.
