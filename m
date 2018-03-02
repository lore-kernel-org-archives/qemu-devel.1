Received: from eggs.gnu.org ([2001:4830:134:3::10]:59039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1erhad-0003X5-K5
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1erhaa-0008Gj-Gs
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:06:59 -0500
References: <1519944838-12430-1-git-send-email-cota@braap.org>
	<1519944838-12430-13-git-send-email-cota@braap.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <83a59320-8539-2511-3665-2d3141b65857@redhat.com>
Date: Fri, 2 Mar 2018 11:06:37 +0100
MIME-Version: 1.0
In-Reply-To: <1519944838-12430-13-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv1 12/14] target/s390x: convert to
 TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org

On 01.03.2018 23:53, Emilio G. Cota wrote:
> Note: I looked into dropping dc->do_debug. However, I don't see
> an easy way to do it given that TOO_MANY is also valid
> when we just translate more than max_insns. Thus, the check
> for do_debug in "case DISAS_PC_CC_UPDATED" would still need
> additional state to know whether or not we came from
> breakpoint_check.

Looks much cleaner! The do_debug() thing is fine for now.


> -        if (unlikely(cpu_breakpoint_test(cs, dc.base.pc_next, BP_ANY))=
) {
> -            status =3D DISAS_PC_STALE;
> -            do_debug =3D true;
> -            /* The address covered by the breakpoint must be included =
in
> -               [tb->pc, tb->pc + tb->size) in order to for it to be
> -               properly cleared -- thus we increment the PC here so th=
at
> -               the logic setting tb->size below does the right thing. =
 */
> -            dc.base.pc_next +=3D 2;
> -            break;
> -        }
> +    dc->base.is_jmp =3D DISAS_PC_STALE;
> +    dc->do_debug =3D true;
> +    /* The address covered by the breakpoint must be included in
> +       [tb->pc, tb->pc + tb->size) in order to for it to be
> +       properly cleared -- thus we increment the PC here so that
> +       the logic setting tb->size below does the right thing.  */
> +    dc->base.pc_next +=3D 2;

This comment is now wrong. ("the logic in translator_loop()" ?)

Reviewed-by: David Hildenbrand <david@redhat.com>


Gave this series a quick test:

kvm-unit-tests pass (you need to rebase to have all tests passing),
fedora 27 boots

--=20

Thanks,

David / dhildenb
