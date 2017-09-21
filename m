Received: from eggs.gnu.org ([2001:4830:134:3::10]:46963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv5H4-0001Vo-Hs
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv5H2-0001LZ-F1
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:28:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv5H2-0001Jo-2C
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:28:28 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 18:29:01 +0100
Message-Id: <1506014941-31076-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2] docs/devel/loads-stores.rst: Document our
 various load and store APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

QEMU has a wide selection of different functions for doing
loads and stores; provide some overview documentation of
what they do and how to pick which one to use.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Changes v1->v2: filled in most of the gaps thanks to the
comments on v1.

I have left some TODO markers in where they represent
fixes we should ideally make to the API. Since this
is for-developers internals documentation I think it's
OK to leave those in.

I found I was referring back to my v1 patch and the replies
to it quite a bit recently, so I think it would be nice to
get it into the tree.

The major question I have left is about the license text
to apply to this...
---
 docs/devel/loads-stores.rst | 400 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 400 insertions(+)
 create mode 100644 docs/devel/loads-stores.rst

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
new file mode 100644
index 0000000..197dfe9
--- /dev/null
+++ b/docs/devel/loads-stores.rst
@@ -0,0 +1,400 @@
+..
+   Copyright (c) 2017 Linaro Limited
+   Written by Peter Maydell
+   TODO: do we have a standard doc license? bitmaps.rst
+   uses the FreeBSD documentation license, I notice.
+
+===================
+Load and Store APIs
+===================
+
+QEMU internally has multiple families of functions for performing
+loads and stores. This document attempts to enumerate them all
+and indicate when to use them. It does not provide detailed
+documentation of each API -- for that you should look at the
+documentation comments in the relevant header files.
+
+
+``ld*_p and st_*p``
+~~~~~~~~~~~~~~~~~~~
+
+These functions operate on a host pointer, and should be used
+when you already have a pointer into host memory (corresponding
+to guest ram or a local buffer). They deal with doing accesses
+with the desired endianness and with correctly handling
+potentially unaligned pointer values.
+
+Function names follow the pattern:
+
+load: ``ld{type}{sign}{size}_{endian}_p(ptr)``
+
+store: ``st{type}{size}_{endian}_p(ptr, val)``
+
+``type``
+ - (empty) : integer access
+ - ``f`` : float access
+
+``sign``
+ - (empty) : for 32 or 64 bit sizes (including floats and doubles)
+ - ``u`` : unsigned
+ - ``s`` : signed
+
+``size``
+ - ``b`` : 8 bits
+ - ``w`` : 16 bits
+ - ``l`` : 32 bits
+ - ``q`` : 64 bits
+
+``endian``
+ - ``he`` : host endian
+ - ``be`` : big endian
+ - ``le`` : little endian
+
+(except for byte accesses, which have no endian infix).
+
+The ``_{endian}`` infix is omitted for target-endian accesses.
+
+The target endian accessors are only available to source
+files which are built per-target.
+
+Regexes for git grep
+ - ``\<ldf\?[us]\?[bwlq]\(_[hbl]e\)\?_p\>``
+ - ``\<stf\?[bwlq]\(_[hbl]e\)\?_p\>``
+
+``cpu_{ld,st}_*``
+~~~~~~~~~~~~~~~~~
+
+These functions operate on a guest virtual address. Be aware
+that these functions may cause a guest CPU exception to be
+taken (eg for an alignment fault or MMU fault) which will
+result in guest CPU state being updated and control longjumping
+out of the function call. They should therefore only be used
+in code that is implementing emulation of the target CPU.
+
+These functions may throw an exception (longjmp() back out
+to the top level TCG loop). This means they must only be used
+from helper functions where the translator has saved all
+necessary CPU state before generating the helper function call.
+It's usually better to use the ``_ra`` variants described below
+from helper functions, but these functions are the right choice
+for calls made from hooks like the CPU do_interrupt hook or
+when you know for certain that the translator had to save all
+the CPU state that ``cpu_restore_state()`` would restore anyway.
+
+Function names follow the pattern:
+
+load: ``cpu_ld{sign}{size}_{mmusuffix}(env, ptr)``
+
+store: ``cpu_st{size}_{mmusuffix}(env, ptr, val)``
+
+``sign``
+ - (empty) : for 32 or 64 bit sizes
+ - ``u`` : unsigned
+ - ``s`` : signed
+
+``size``
+ - ``b`` : 8 bits
+ - ``w`` : 16 bits
+ - ``l`` : 32 bits
+ - ``q`` : 64 bits
+
+``mmusuffix`` is one of the generic suffixes ``data`` or ``code``, or
+(for softmmu configs) a target-specific MMU mode suffix as defined
+in the target's ``cpu.h``.
+
+Regexes for git grep
+ - ``\<cpu_ld[us]\?[bwlq]_[a-zA-Z0-9]\+\>``
+ - ``\<cpu_st[bwlq]_[a-zA-Z0-9]\+\>``
+
+``cpu_{ld,st}_*_ra``
+~~~~~~~~~~~~~~~~~~~~
+
+Thes functions work like the ``cpu_{ld,st}_*`` functions except
+that they also take a ``retaddr`` argument. This extra argument
+allows for correct unwinding of any exception that is taken,
+and should generally be the result of GETPC() called directly
+from the top level HELPER(foo) function (ie the return address
+in the generated code).
+
+These are generally the preferred way to do accesses by guest
+virtual address from helper functions; see the documentation
+of the non-``_ra`` variants for when those would be better.
+
+Calling these functions with a ``retaddr`` argument of 0 is
+equivalent to calling the non-``_ra`` version of the function.
+
+Function names follow the pattern:
+
+load: ``cpu_ld{sign}{size}_{mmusuffix}_ra(env, ptr, retaddr)``
+
+store: ``cpu_st{sign}{size}_{mmusuffix}_ra(env, ptr, val, retaddr)``
+
+Regexes for git grep
+ - ``\<cpu_ld[us]\?[bwlq]_[a-zA-Z0-9]\+_ra\>``
+ - ``\<cpu_st[bwlq]_[a-zA-Z0-9]\+_ra\>``
+
+``helper_*_{ld,st}*mmu``
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+These functions are intended primarily to be called by the code
+generated by the TCG backend. They may also be called by target
+CPU helper function code. Like the ``cpu_{ld,st}_*_ra`` functions
+they perform accesses by guest virtual address; the difference is
+that these functions allow you to specify an ``opindex`` parameter
+which encodes (among other things) the mmu index to use for the
+access. This is necessary if your helper needs to make an access
+via a specific mmu index (for instance, an "always as non-privileged"
+access) rather than using the default mmu index for the current state
+of the guest CPU.
+
+The ``opindex`` parameter should be created by calling ``make_memop_idx()``.
+
+The ``retaddr`` parameter should be the result of GETPC() called directly
+from the top level HELPER(foo) function (or 0 if no guest CPU state
+unwinding is required).
+
+**TODO** The names of these functions are a bit odd for historical
+reasons because they were originally expected to be called only from
+within generated code. We should rename them to bring them
+more in line with the other memory access functions.
+
+load: ``helper_{endian}_ld{sign}{size}_mmu(env, addr, opindex, retaddr)``
+
+load (code): ``helper_{endian}_ld{sign}{size}_cmmu(env, addr, opindex, retaddr)``
+
+store: ``helper_{endian}_st{size}_mmu(env, addr, val, opindex, retaddr)``
+
+``sign``
+ - (empty) : for 32 or 64 bit sizes
+ - ``u`` : unsigned
+ - ``s`` : signed
+
+``size``
+ - ``b`` : 8 bits
+ - ``w`` : 16 bits
+ - ``l`` : 32 bits
+ - ``q`` : 64 bits
+
+``endian``
+ - ``le`` : little endian
+ - ``be`` : big endian
+ - ``ret`` : target endianness
+
+Regexes for git grep
+ - ``\<helper_\(le\|be\|ret\)_ld[us]\?[bwlq]_c\?mmu\>``
+ - ``\<helper_\(le\|be\|ret\)_st[bwlq]_mmu\>``
+
+``address_space_*``
+~~~~~~~~~~~~~~~~~~~
+
+These functions are the primary ones to use when emulating CPU
+or device memory accesses. They take an AddressSpace, which is the
+way QEMU defines the view of memory that a device or CPU has.
+(They generally correspond to being the "master" end of a hardware bus
+or bus fabric.)
+
+Each CPU has an AddressSpace. Some kinds of CPU have more than
+one AddressSpace (for instance ARM guest CPUs have an AddressSpace
+for the Secure world and one for NonSecure if they implement TrustZone).
+Devices which can do DMA-type operations should generally have an
+AddressSpace. There is also a "system address space" which typically
+has all the devices and memory that all CPUs can see. (Some older
+device models use the "system address space" rather than properly
+modelling that they have an AddressSpace of their own.)
+
+Functions are provided for doing byte-buffer reads and writes,
+and also for doing one-data-item loads and stores.
+
+In all cases the caller provides a MemTxAttrs to specify bus
+transaction attributes, and can check whether the memory transaction
+succeeded using a MemTxResult return code.
+
+``address_space_read(address_space, addr, attrs, buf, len)``
+
+``address_space_write(address_space, addr, attrs, buf, len)``
+
+``address_space_rw(address_space, addr, attrs, buf, len, is_write)``
+
+``address_space_ld{sign}{size}_{endian}(address_space, addr, attrs, txresult)``
+
+``address_space_st{size}_{endian}(address_space, addr, val, attrs, txresult)``
+
+``sign``
+ - (empty) : for 32 or 64 bit sizes
+ - ``u`` : unsigned
+
+(No signed load operations are provided.)
+
+``size``
+ - ``b`` : 8 bits
+ - ``w`` : 16 bits
+ - ``l`` : 32 bits
+ - ``q`` : 64 bits
+
+``endian``
+ - ``le`` : little endian
+ - ``be`` : big endian
+
+The ``_{endian}`` suffix is omitted for byte accesses.
+
+Regexes for git grep
+ - ``\<address_space_\(read\|write\|rw\)\>``
+ - ``\<address_space_ldu\?[bwql]\(_[lb]e\)\?\>``
+ - ``\<address_space_st[bwql]\(_[lb]e\)\?\>``
+
+``{ld,st}*_phys``
+~~~~~~~~~~~~~~~~~
+
+These are functions which are identical to
+``address_space_{ld,st}*``, except that they always pass
+``MEMTXATTRS_UNSPECIFIED`` for the transaction attributes, and ignore
+whether the transaction succeeded or failed.
+
+The fact that they ignore whether the transaction succeeded means
+they should not be used in new code, unless you know for certain
+that your code will only be used in a context where the CPU or
+device doing the access has no way to report such an error.
+
+``load: ld{sign}{size}_{endian}_phys``
+
+``store: st{size}_{endian}_phys``
+
+``sign``
+ - (empty) : for 32 or 64 bit sizes
+ - ``u`` : unsigned
+
+(No signed load operations are provided.)
+
+``size``
+ - ``b`` : 8 bits
+ - ``w`` : 16 bits
+ - ``l`` : 32 bits
+ - ``q`` : 64 bits
+
+``endian``
+ - ``le`` : little endian
+ - ``be`` : big endian
+
+The ``_{endian}_`` infix is omitted for byte accesses.
+
+Regexes for git grep
+ - ``\<ldu\?[bwlq]\(_[bl]e\)\?_phys\>``
+ - ``\<st[bwlq]\(_[bl]e\)\?_phys\>``
+
+``cpu_physical_memory_*``
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+These are convenience functions which are identical to
+``address_space_*`` but operate specifically on the system address space,
+always pass a ``MEMTXATTRS_UNSPECIFIED`` set of memory attributes and
+ignore whether the memory transaction succeeded or failed.
+For new code they are better avoided:
+
+* there is likely to be behaviour you need to model correctly for a
+  failed read or write operation
+* a device should usually perform operations on its own AddressSpace
+  rather than using the system address space
+
+``cpu_physical_memory_read``
+
+``cpu_physical_memory_write``
+
+``cpu_physical_memory_rw``
+
+Regexes for git grep
+ - ``\<cpu_physical_memory_\(read\|write\|rw\)\>``
+
+``cpu_physical_memory_write_rom``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This function performs a write by physical address like
+``address_space_write``, except that if the write is to a ROM then
+the ROM contents will be modified, even though a write by the guest
+CPU to the ROM would be ignored.
+
+Note that unlike ``cpu_physical_memory_write()`` this function takes
+an AddressSpace argument, but unlike ``address_space_write()`` this
+function does not take a ``MemTxAttrs`` or return a ``MemTxResult``.
+
+**TODO**: we should probably clean up this inconsistency and
+turn the function into ``address_space_write_rom`` with an API
+matching ``address_space_write``.
+
+``cpu_physical_memory_write_rom``
+
+
+``cpu_memory_rw_debug``
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Access CPU memory by virtual address for debug purposes.
+
+This function is intended for use by the GDB stub and similar code.
+It takes a virtual address, converts it to a physical address via
+an MMU lookup using the current settings of the specified CPU,
+and then performs the access (using ``address_space_rw`` for
+reads or ``cpu_physical_memory_write_rom`` for writes).
+This means that if the access is a write to a ROM then this
+function will modify the contents (whereas a normal guest CPU access
+would ignore the write attempt).
+
+``cpu_memory_rw_debug``
+
+``dma_memory_*``
+~~~~~~~~~~~~~~~~
+
+These behave like ``address_space_*``, except that they perform a DMA
+barrier operation first.
+
+**TODO**: We should provide guidance on when you need the DMA
+barrier operation and when it's OK to use ``address_space_*``, and
+make sure our existing code is doing things correctly.
+
+``dma_memory_read``
+
+``dma_memory_write``
+
+``dma_memory_rw``
+
+Regexes for git grep
+ - ``\<dma_memory_\(read\|write\|rw\)\>``
+
+``pci_dma_*`` and ``{ld,st}*_pci_dma``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+These functions are specifically for PCI device models which need to
+perform accesses where the PCI device is a bus master. You pass them a
+``PCIDevice *`` and they will do ``dma_memory_*`` operations on the
+correct address space for that device.
+
+``pci_dma_read``
+
+``pci_dma_write``
+
+``pci_dma_rw``
+
+``load: ld{sign}{size}_{endian}_pci_dma``
+
+``store: st{size}_{endian}_pci_dma``
+
+``sign``
+ - (empty) : for 32 or 64 bit sizes
+ - ``u`` : unsigned
+
+(No signed load operations are provided.)
+
+``size``
+ - ``b`` : 8 bits
+ - ``w`` : 16 bits
+ - ``l`` : 32 bits
+ - ``q`` : 64 bits
+
+``endian``
+ - ``le`` : little endian
+ - ``be`` : big endian
+
+The ``_{endian}_`` infix is omitted for byte accesses.
+
+Regexes for git grep
+ - ``\<pci_dma_\(read\|write\|rw\)\>``
+ - ``\<ldu\?[bwlq]\(_[bl]e\)\?_pci_dma\>``
+ - ``\<st[bwlq]\(_[bl]e\)\?_pci_dma\>``
-- 
2.7.4
