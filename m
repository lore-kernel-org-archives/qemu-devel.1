Received: from eggs.gnu.org ([2001:4830:134:3::10]:55863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4kdD-00036Q-K6
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4kd9-0001RO-NU
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:27:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e4kd9-0001Px-HC
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:27:15 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <cfb8e3d0-7c4e-f83f-3887-18e6af8b0418@redhat.com> (Laurent
	Vivier's message of "Wed, 18 Oct 2017 11:09:19 +0200")
References: <20171018083305.5246-1-quintela@redhat.com>
	<cfb8e3d0-7c4e-f83f-3887-18e6af8b0418@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 18 Oct 2017 11:27:09 +0200
Message-ID: <874lqwolg2.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] tpm: Fix compilation with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, peterx@redhat.com, Amarnath Valluri <amarnath.valluri@intel.com>

Laurent Vivier <lvivier@redhat.com> wrote:
> On 18/10/2017 10:33, Juan Quintela wrote:
>> Commit
>>    c37cacabf2285b0731b44c1f667781fdd4f2b658
>> 
>> broke compilation without tpm.  Just add an empty tpm_cleanup() stub.
>
> tpm_init() and tpm_config_parse() are managed in a different way: they
> are included in a "#ifdef CONFIG_TPM .. #endif" in vl.c
>
> I think you should follow the same way.

tpm is weird (TM):

in include/sysemu/tpm.h we do that in an incline function

static inline TPMVersion tpm_get_version(void)
{
#ifdef CONFIG_TPM
    Object *obj = object_resolve_path_type("", TYPE_TPM_TIS, NULL);

    if (obj) {
        return tpm_tis_get_tpm_version(obj);
    }
#endif
    return TPM_VERSION_UNSPEC;
}


tpm.c, we have an ifdef in the middle of the file

#ifdef CONFIG_TPM

#endif


vl.c, we protect tpm_* calls with CONFIG_TPM

#ifdef CONFIG_TPM
            case QEMU_OPTION_tpmdev:
                if (tpm_config_parse(qemu_find_opts("tpmdev"), optarg) < 0) {
                    exit(1);
                }
                break;
#endif


but we almost never do:

#ifdef CONFIG_TPM
   tpm_cleanup()
#endif

We normally create an stub function.

So ......

We are going to be inconsistent whatever we did.

I would have vote for

#ifdef CONFIG_TPM
void tpm_cleanup(void);
#else
static inline void tpm_cleanup(void) {}
#endif

On the header file (it was my first solution), but having CONFIG_TPM on
tpm.c sounded gross.

So ....

I think that now that the problem is spotted, I will left the choose of
the solution to the maintaner O:-)

Later, Juan.
