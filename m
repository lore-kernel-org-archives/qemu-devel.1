Received: from eggs.gnu.org ([2001:4830:134:3::10]:35248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dpCWT-0003XY-Gv
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dpCWO-0004d3-Gf
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:00:05 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:52437)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dpCWO-0004co-4a
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:00:00 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
References: <8c62454c-828b-0f16-76dd-227d9c52af1d@erigones.com>
	<20170829100806.GO25960@stefanha-x1.localdomain>
	<2bfb1acd-cd69-a719-0c18-a5684367da04@erigones.com>
	<20170905103339.GK17449@stefanha-x1.localdomain>
	<362720ab-5bf6-57f6-349d-b7462aef9427@msgid.tls.msk.ru>
Message-ID: <250b757d-34a8-76bf-dacd-1093d45da588@msgid.tls.msk.ru>
Date: Tue, 5 Sep 2017 14:59:59 +0300
MIME-Version: 1.0
In-Reply-To: <362720ab-5bf6-57f6-349d-b7462aef9427@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] wrong ioctl error handling on dirty pages sync?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?J=c3=a1n_Poctavek?= <jan.poctavek@erigones.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

05.09.2017 14:57, Michael Tokarev =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> 05.09.2017 13:33, Stefan Hajnoczi =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On Mon, Sep 04, 2017 at 02:52:57PM +0200, J=C3=A1n Poctavek wrote:
>>>
>>> On 29. 8. 2017 12:08, Stefan Hajnoczi wrote:
>>>> On Fri, Aug 25, 2017 at 01:42:55PM +0200, J=C3=A1n Poctavek wrote:
>>>>> Hi guys,
>>>>>
>>>>> Maybe it is just my lack of understanding, this seems like a bug to=
 me:
>>>>>
>>>>> To get list of dirty pages, qemu calls kvm_vm_ioctl() with
>>>>> KVM_GET_DIRTY_LOG:
>>>>> https://github.com/qemu/qemu/blob/v2.10.0-rc4/accel/kvm/kvm-all.c#L=
494
>>>>>
>>>>> and considers the ioctl call failed when -1 is returned.
>>>>>
>>>>> But the kvm_vm_ioctl() itself returns -errno, not the -1 on error:
>>>>> https://github.com/qemu/qemu/blob/v2.10.0-rc4/accel/kvm/kvm-all.c#L=
2142
>>>>>
>>>>> Thanks in advance for sheding some light into this for me.
>>>> Looks like a bug to me.  Do you want to send a patch?
>>>>
>>>> Guidelines on how to submit a patch are here:
>>>> http://wiki.qemu.org/Contribute/SubmitAPatch
>>>>
>>>> Stefan
>>>
>>> It seems that the patch has already been created a long time ago. But=
 it is
>>> still not included:
>>>
>>> https://lists.nongnu.org/archive/html/qemu-devel/2014-03/msg03996.htm=
l
>>>
>>> Can I help with this somehow?
>>
>> Michael: Do you know what happened to this -trivial patch?
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2014-03/msg05347.html
> https://lists.gnu.org/archive/html/qemu-devel/2014-03/msg05346.html
> https://lists.gnu.org/archive/html/qemu-devel/2014-03/msg05402.html
>=20
> -- according to the emails, it has been applied, but I don't see it in
> the git tree.  Hmm..

Aha.  Here we go:

commit 50212d6346f33d6e19489e81b025b5c3bb8759be
Author: Michael Tokarev <mjt@tls.msk.ru>
Date:   Mon Apr 14 16:14:04 2014 +0400

    Revert "fix return check for KVM_GET_DIRTY_LOG ioctl"

    This reverts commit b533f658a98325d0e47b36113bd9f5bcc046fdae.

    The original code was wrong, because effectively it ignored errors
    from kernel, because kernel does not return -1 on error case but
    returns -errno, and does not return -EPERM for this particular ioctl.
    But in some cases kernel actually returned unsuccessful result,
    namely, when the dirty bitmap in requested slot does not exist
    it returns -ENOENT.  With new code this condition becomes an
    error when it shouldn't be.

    Revert that patch instead of fixing it properly this late in the
    release process.  I disagree with this approach, but let's make
    things move _somewhere_, instead of arguing endlessly whch of
    the 2 proposed fixes is better.

    Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
    Message-id: 1397477644-902-1-git-send-email-mjt@msgid.tls.msk.ru
    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

/mjt
