Received: from eggs.gnu.org ([2001:4830:134:3::10]:45411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dicvt-0000Ew-5N
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dicvq-0000Az-1r
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:47:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dicvp-00006f-Rs
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:47:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7680CC0587D9
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 08:47:04 +0000 (UTC)
Received: from [10.36.116.94] (ovpn-116-94.ams2.redhat.com [10.36.116.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 005656EE3B
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 08:47:03 +0000 (UTC)
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-3-git-send-email-thuth@redhat.com>
	<20170817104122.4d72674b.cohuck@redhat.com>
	<98d06e4e-b0e9-9a44-195a-3aab6f3cf219@redhat.com>
	<20170818095448.226fc4e9.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <09806f49-6b93-9252-4dbf-202d87d439ed@redhat.com>
Date: Fri, 18 Aug 2017 10:47:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170818095448.226fc4e9.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] tests: Add network filter tests to the
 check-qtest-s390x list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 18.08.2017 09:54, Cornelia Huck wrote:
> On Thu, 17 Aug 2017 16:02:00 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> On 17.08.2017 10:41, Cornelia Huck wrote:
[...]
>>> I'm wondering if we could unify selection of the network device
>>> somehow. There's probably two cases:
>>> - Test a specific device. This obviously needs to be decided
>>>   individually.
>>> - Just use a functional network device. For s390x, this will be
>>>   virtio-net-ccw; for other architectures, this test uses e1000, whil=
e
>>>   one of the tests below uses rtl8139 (why?). A helper for that may b=
e
>>>   useful. =20
>>
>> Maybe ... OTOH, this likely increases also test coverage if we do not
>> use the same PCI NIC in all the tests...?
>=20
> It just looks like a bit of unneeded churn to me.
>=20
> Re coverage: Do we have a very simple test that we can run for all kind
> of NICs? This would give some reliable testing for various devices
> instead of having to rely on people picking different devices for their
> tests...

I think there is only the pxe-tester that comes close to a generic NIC
tester. But there are two issues:
1) You need a firmware that has a driver for the NIC
2) It's not a very fast test, so adding lots of NICs there might slow
   down "make check" quite a bit.

(There are also some dedicated NIC tests available already, e.g.
tests/rtl8139-test.c tests at least some aspects of that NIC.)

Hmm, maybe we could also use a function that returns a different NIC for
the i386 and x86_64 architectures, something like:

char *get_preferred_nic_name(void)
{
    const char *arch =3D qtest_get_arch();

    if (g_str_equal(arch, "i386")) {
        return "rtl8139";
    } else if (g_str_equal(arch, "s390x")) {
        return "virtio-net-ccw";
    } else if (g_str_equal(arch, "ppc64")) {
        return "spapr-vlan";
    } else {
        return "e1000";
    }
}

That way, we'd also get test coverage for both, e1000 and rtl8139... ?

 Thomas
